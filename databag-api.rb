#!/usr/bin/env ruby

load "config.rb"

require "sinatra"
require "ridley"

def get_chef_client()
  ridley = Ridley.new(
    server_url: CHEF_SERVER_URL,
    client_name: CHEF_CLIENT_NAME,
    client_key: CHEF_CLIENT_KEY,
    ssl: {
      verify: false
    }
  )
  return ridley
end

def get_databag_list
  ridley = get_chef_client()
  return ridley.data_bag.all()
end

def get_databag(databag)
  ridley = get_chef_client()
  return ridley.data_bag.find(databag)
end

def get_databag_item(databag, item)
  ridley = get_chef_client()
  my_databag = ridley.data_bag.find(databag)
  return my_databag.item.find(item)
end

get "/" do
  content_type :json
  response = {}
  response[:items] = []
  databag_list = get_databag_list()
  response[:total] = databag_list.length
  databag_list.each do |name|
    databag = {}
    databag["databag_name"] = name.chef_id
    databag["databag"] = File.join(API_BASE_URL, name.chef_id)
    response[:items].push(databag)
  end
  response.to_json()
end

get "/all" do
  content_type :json
  response = {}
  databag_list = get_databag_list()
  databag_list.to_json()
end

get "/:databag" do
  content_type :json
  name = params[:databag]
  my_databag = get_databag(name)
  response = {}
  response[:name] = name
  response[:items] = []
  my_databag.item.all.each do |item|
    response[:items].push File.join(API_BASE_URL, name, item.chef_id)
  end
  response.to_json()
end

get "/:databag/:item" do
  content_type :json
  name = params[:databag]
  item = params[:item]

  my_databag_item = get_databag_item(name, item)
  my_databag_item.to_json()
end
