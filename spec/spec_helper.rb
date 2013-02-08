require File.join(File.dirname(__FILE__), '../app')

require 'rspec'
require 'rack/test'
require 'webrat'

module AppHelper
  def app
    Sinatra::Application
  end
end

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.color_enabled = true
  config.tty = true
  config.formatter = :documentation # :progress, :html, :textmate
  config.include Webrat::Methods
  config.include Webrat::Matchers
  config.include AppHelper
end

Webrat.configure do |config|
  config.mode = :rack
end

