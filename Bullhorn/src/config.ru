$:.push File.dirname(__FILE__)

ENV['RACK_ENV'] ||= 'development'

require 'environment'
require 'application'

run Sinatra::Application
