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
