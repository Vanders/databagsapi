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

Configuration options are loaded from `databag-api.env`. A `sample.env` is provided. The configuration options are

 * CHEF_SERVER_URL - Chef server API URL
 * CHEF_CLIENT_NAME - Chef client name
 * CHEF_CLIENT_KEY - Chef client key
 * API_BASE_URL - The base URL of the Sinatra app. This is used to make links back to itself.
