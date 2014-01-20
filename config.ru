# encoding: utf-8
#
# Copyright 2014 Dyn Inc.
#
# Authors: Kristian Van Der Vliet <kvandervliet@dyn.com>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
require 'sinatra'

########## Configuration block
CHEF_SERVER_URL ||= ENV['CHEF_SERVER_URL'] || 'https://localhost'
CHEF_CLIENT_NAME ||= ENV['CHEF_CLIENT_NAME'] || 'databag-api'
CHEF_CLIENT_KEY ||= ENV['CHEF_CLIENT_KEY'] || 'client.pem'

API_BASE_URL ||= ENV['API_BASE_URL'] || 'https://localhost:8080/'
########## End configuration block

require File.dirname(__FILE__) + '/databag-api'

run Sinatra::Application
