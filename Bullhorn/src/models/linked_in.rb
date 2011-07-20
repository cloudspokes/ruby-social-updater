require 'linkedin'

class LinkedInService < Service
  def initialize(credentials_hash)
    @token  = credentials_hash['token']
    @secret = credentials_hash['secret']
  end

  def client
    @client ||= LinkedIn::Client.new(ENV['LINKEDIN_KEY'], ENV['LINKEDIN_SECRET'])
    @client.authorize_from_access(@token, @secret)
  end

  def post(text)
    @client.update_status(text)
  rescue LinkedIn::LinkedInError
    false
  end
end
