class Service
  def initialize(auth_hash)
    raise NotImplementedError
  end

  def post!(text)
    raise NotImplementedError
  end
end

require 'twitter'

class TwitterService < Service
  def initialize(credentials_hash)
    @token = credentials_hash['token']
    @secret = credentials_hash['secret']
  end
  
  def post(text)
    Twitter.configure do |config|
      config.consumer_key = ENV['TWITTER_KEY']
      config.consumer_secret = ENV['TWITTER_SECRET']
      config.oauth_token = @token
      config.oauth_token_secret = @secret
    end

    Twitter.update(text)
  rescue Twitter::Error
    false
  end
end

require 'koala'

class FacebookService < Service
  def initialize(credentials_hash)
    @token = credentials_hash['token']
  end

  def client
    Koala::Facebook::GraphAPI.new(@token)
  end

  def post(text)
    client.put_object("me","feed", :message => text)
  rescue Koala::APIError
    false
  end
end

require 'linkedin'

class LinkedInService < Service
  def initialize(credentials_hash)
    @token  = credentials_hash['token']
    @secret = credentials_hash['secret']
  end

  def client
    @client ||= LinkedIn::Client.new(ENV['LINKEDIN_KEY'], ENV['LINKEDIN_SECRET'])
    @client.authorize_from_access(@token, @secret)
    @client
  end

  def post(text)
    client.update_status(text)
  rescue LinkedIn::LinkedInError
    false
  end
end

