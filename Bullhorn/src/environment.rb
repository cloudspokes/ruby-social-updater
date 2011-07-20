$:.push File.dirname(__FILE__)
$:.push File.dirname(__FILE__) + '/models'

require 'rubygems'
require 'bundler'

Bundler.setup :default, ENV['RACK_ENV']
