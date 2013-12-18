databag-api
============

A simple sinatra app that can act as a site api endpoint for Berkshelf that pulls databag items from a Chef API

Author
======
Dyn Inc - http://dyn.com  
Kristian Van Der Vliet <kvandervliet@dyn.com>

License
=======

Apache 2.0  
http://www.apache.org/licenses/LICENSE-2.0.txt

Configuration
=============

Configuration options are all at the start of cookbook-api.rb

 * CHEF_SERVER_URL - The API URL to connect to where the script can download the cookbooks it serves
 * CHEF_CLIENT_NAME - The name of the client to connect to the API with
 * CHEF_CLIENT_KEY - The key for the client to use to connect
 * API_BASE_URL - The base URL the sinatra app will be listening at (used to make links back to itself)
