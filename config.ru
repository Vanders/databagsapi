require 'rubygems'
require 'sinatra'

########## Configuration block
CHEF_SERVER_URL ||= ENV['CHEF_SERVER_URL'] || 'https://localhost'
CHEF_CLIENT_NAME ||= ENV['CHEF_CLIENT_NAME'] || 'databag-api'
CHEF_CLIENT_KEY ||= ENV['CHEF_CLIENT_KEY'] || 'client.pem'

API_BASE_URL ||= ENV['API_BASE_URL'] || 'https://localhost:8080/'
########## End configuration block

require File.dirname(__FILE__) + '/databag-api.rb'

run Sinatra::Application
