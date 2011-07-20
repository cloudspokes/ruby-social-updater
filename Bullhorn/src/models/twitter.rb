require 'twitter'

class TwitterService < Service
  def initialize(credentials_hash)
    @token = credentials['token']
    @secret = credentials['secret']
  end
  
  def post(text)
    Twitter.configure do |config|
      config.consumer_key = ENV['TWITTER_KEY']
      config.consumer_secret = ENV['TWITTER_SECRET']
      config.oauth_token = @token
      config.oauth_secret = @secret
    end

    Twitter.update(text)
  rescue Twitter::Error
    false
  end
end
