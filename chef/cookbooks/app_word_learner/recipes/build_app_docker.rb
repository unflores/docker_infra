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

#Ensure the directory structure

directory "/infra/app_word_learner" do
  recursive true
  action :create
  user 'vagrant'
  group 'vagrant'
end

log 'Docker App portion' do
  message '======== Filling Docker Portion of app_word_learner'
  level :info
end



['Gemfile', 'Gemfile.lock'].each do |file|
    execute "Copying app_word_learner file: #{file} to docker dir" do
      command "cp #{recipe[:deploy_path]}/current/#{file} /infra/app_word_learner/"
      user "vagrant"
      action :run
    end
end

execute "Copying app_word_learner file: unicorn.rb to docker dir" do
  command "cp #{recipe[:deploy_path]}/current/config/unicorn.rb /infra/app_word_learner/"
  user "vagrant"
  action :run
end

# File requires Gemfile,Gemfile.lock and unicorn.rb from project
template '/infra/app_word_learner/Dockerfile' do
  source 'app_word_learner/Dockerfile.erb'
  owner 'vagrant'
  group 'vagrant'
  mode '0644'
  variables environment: node.environment
end

template '/infra/app_word_learner/word_learner.sh' do
  source 'app_word_learner/word_learner.sh.erb'
  owner 'vagrant'
  group 'vagrant'
  mode '0644'
  variables({ port: recipe[:app_port] })
end

ruby_block 'Set up current version for docker container' do
  block do
    version = File.readlink("/infra/deployment/word_learner/current").split('/').last
    File.open("/infra/app_word_learner/version", 'w') { |file| file.write(version) }
  end

  action :run
end


template '/infra/app_word_learner/build_latest_container' do
  source 'app_word_learner/build_latest_container.erb'
  owner 'vagrant'
  group 'vagrant'
  mode '0700'
  variables({ port: recipe[:app_port] })
end
