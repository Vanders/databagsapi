require 'sinatra'
require 'test/unit'
require 'rack/test'
require 'json'

ENV['RACK_ENV'] = 'test'
ENV['API_BASE_URL'] = ''

describe 'databag-api' do
  include Rack::Test::Methods

  def app
    @app ||= eval "Rack::Builder.new {( " + File.read(File.dirname(__FILE__) + '/../config.ru') + "\n )}"
  end

  def get_databag_list
    get '/'
    expect(last_response).to be_ok, 'Request failed'
    begin
      response = JSON.parse(last_response.body)
      valid_json = true 
    rescue
      valid_json = false
    end
    expect(valid_json).to be_true, 'Response is not valid JSON'

    return response
  end

  def get_databag_items_list
    databags = get_databag_list
    expect(databags['items'].length).to be > 0, 'No data bags in response'  

    # Select the first data bag and get a list of items
    bag = databags['items'].first['databag']

    get bag
    expect(last_response).to be_ok, 'Request failed'
    begin
      databag_items = JSON.parse(last_response.body)
      valid_json = true 
    rescue
      valid_json = false
    end
    expect(valid_json).to be_true, 'Response is not valid JSON'

    return databag_items
  end

  it "returns a list of databags" do
    get_databag_list
  end

  it "returns a list of databag items" do
    get_databag_items_list
  end

  it "returns a databag item" do
    bag_items = get_databag_items_list
    expect(bag_items['items'].length).to be > 0, 'No data bag items in response'

    item = bag_items['items'].first

    get item
    expect(last_response).to be_ok, 'Request failed'
    begin
      JSON.parse(last_response.body)
      valid_json = true
    rescue
      valid_json = false
    end
    expect(valid_json).to be_true, 'Response is not valid JSON'

  end
end
