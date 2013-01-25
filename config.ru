ENV["RACK_ENV"] ||= "development"

require 'rubygems'
require 'bundler'

Bundler.require(:default, ENV["RACK_ENV"].to_sym)
Dir["./lib/**/*.rb"].each { |f| require f }

require "#{File.dirname(__FILE__)}/app"
run Sinatra::Application

