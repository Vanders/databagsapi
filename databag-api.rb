#!/usr/bin/env ruby

load 'config.rb'

require 'sinatra'
require 'chef'

def chef_rest(location)
  conn = Chef::REST.new(
    CHEF_SERVER_URL,
    CHEF_CLIENT_NAME,
    CHEF_CLIENT_KEY
  )

  begin
    conn.get(location)
  rescue Net::HTTPServerException => ex
    $stderr.puts "#{location} : #{ex}"
  end
end

def get_databag_list
  chef_rest('data')
end

def get_databag(databag)
  chef_rest("data/#{databag}")
end

def get_databag_item(databag, item)
  chef_rest("data/#{databag}/#{item}")
end

get "/" do
  content_type :json
  response = {}
  response[:items] = []
  databag_list = get_databag_list()
  response[:total] = databag_list.length
  databag_list.each do |name, location|
    databag = {}
    databag["databag_name"] = name
    databag["databag"] = File.join(API_BASE_URL, name)
    response[:items].push(databag)
  end
  response.to_json
end

get "/all" do
  content_type :json
  response = {}
  databag_list = get_databag_list()
  databag_list.to_json
end

get "/:databag" do
  content_type :json
  name = params[:databag]
  my_databag = get_databag(name)
  response = {}
  response[:name] = name
  response[:items] = []
  my_databag.each do |item, location|
    response[:items].push File.join(API_BASE_URL, name, item)
  end
  response.to_json
end

get "/:databag/:item" do
  content_type :json
  name = params[:databag]
  item = params[:item]

  item = get_databag_item(name, item)
  item.to_json
end
