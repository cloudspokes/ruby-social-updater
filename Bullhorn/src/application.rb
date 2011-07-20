require File.dirname(__FILE__) + '/environment'
require 'sinatra'
require 'omniauth/oauth'
require 'service'

use Rack::Session::Cookie, :expire_after => 31536000
set :session_secret, 'BULLHORN!!@!@!@'

use OmniAuth::Builder do
  provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET']
  provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET'], :scope => 'publish_stream'
  provider :linked_in, ENV['LINKEDIN_KEY'], ENV['LINKEDIN_SECRET']
end

helpers do
  def service?(name)
    !!session[name]
  end
end

get '/' do
  @success = (params[:message] == 'success')
  @failure = (params[:message] == 'failure')
  erb :home
end

get '/session' do
  session.inspect
end

get '/auth/:provider/callback' do
  auth = env['omniauth.auth']

  session[auth['provider']] = auth['credentials']
  redirect '/'
end

get '/sign_out' do
  session.keys.each do |k|
    session[k] = nil
  end
  redirect '/'
end

HANDLERS = {
  'twitter' => TwitterService,
  'facebook' => FacebookService,
  'linked_in' => LinkedInService
}

post '/post' do
  message = params[:update][:text]
  @successes = []
  @failures = []

  HANDLERS.keys.each do |service|
    if session[service] && (params[:update][:services] || {})[service] == 'true'
      if HANDLERS[service].new(session[service]).post(message)
        @successes << service
      else
        @failures << service
      end
    end
  end

  url = '/?message='
  if @successes.any?
    url << 'success'
  else
    url << 'failure'
  end
  redirect url
end

##########

get '/stylesheets/application.css' do
  headers 'Content-Type' => 'text/css; charset=utf-8'
  sass :application
end
