#
# Cookbook Name:: app_word_learner
# Recipe:: default
#
# Copyright 2015, No Company
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
recipe = node[:app_word_learner]

log 'Docker Webserver portion' do
  message '======== Filling Webserver Portion of Docker'
  level :info
end

log 'ensure_dir_struct Webserver' do
  message '========= Building the Webserver Docker dir structure ========='
  level :info
end

#Ensure the directory structure
[ 'conf.d', 'ssl' ].each do |dir|
    directory "/infra/webserver/etc/nginx/#{dir}" do
      owner 'vagrant'
      group 'vagrant'
      recursive true
      action :create
    end
end

template '/infra/webserver/Dockerfile' do
  source 'webserver/Dockerfile.erb'
  owner 'vagrant'
  group 'vagrant'
  mode '0644'
end

template '/infra/webserver/etc/nginx/conf.d/default.conf' do
  source 'webserver/default.conf.erb'
  owner 'vagrant'
  group 'vagrant'
  mode '0644'
end

keys = Chef::EncryptedDataBagItem.load('apps', 'keys')

file '/infra/webserver/etc/nginx/ssl/nginx.crt' do
  content keys[node.environment]['nginx_crt']
  owner 'vagrant'
  group 'vagrant'
  mode '0600'
end

file '/infra/webserver/etc/nginx/ssl/nginx.key' do
  content keys[node.environment]['nginx_key']
  owner 'vagrant'
  group 'vagrant'
  mode '0600'
end


template '/infra/webserver/build_latest_container' do
  source 'webserver/build_latest_container.erb'
  owner 'vagrant'
  group 'vagrant'
  mode '0700'
  variables({ port: recipe[:server_port] })
end
