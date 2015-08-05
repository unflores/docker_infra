#
# Cookbook Name:: system
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

bash 'build docker' do
  code <<-EOH
    wget -qO- https://get.docker.com/ | sed 's/lxc-docker/lxc-docker-1.7.1/' | sh
    EOH
  not_if 'docker -v|grep "Docker version"'
end

bash "Set docker regular user privileges for #{node['system']['user']}" do
    code "usermod -aG docker #{node['system']['user']}"
    user 'root'
end
