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

log 'ensure_dir_struct' do
  message '========= Building the app dir structure ========='
  level :info
end

#Ensure the directory structure
[ recipe[:wrappers_path], recipe[:keys_path] ].each do |dir|
    directory dir do
      recursive true
      action :create
    end
end


['releases', 'repo', 'shared'].each do |dir|

    directory "#{recipe[:deploy_path]}/#{dir}" do
      owner 'vagrant'
      group 'vagrant'
      recursive true
      action :create
    end

end

template recipe[:wrappers_path] + '/word_learner_wrapper.sh' do
  source 'app_word_learner/wrapper.erb'
  mode '0700'
  variables({app_name: 'word_learner'})
end

keys = Chef::EncryptedDataBagItem.load('apps', 'keys')

file recipe[:keys_path] + '/word_learner_deploy_key' do
  content keys['development']['word_learner_deploy_key']
  mode '0600'
end

execute "chown-vagrant #{recipe[:app_base_path]}" do
  command "chown -R vagrant:vagrant #{recipe[:app_base_path]}"
  user "root"
  action :run
end

git '/infra/deployment/word_learner/repo' do
   repository recipe[:repo]
   reference recipe[:branch]
   ssh_wrapper recipe[:wrappers_path] + '/word_learner_wrapper.sh'
   action :sync
   user 'vagrant'
   group 'vagrant'
end

release = Time.now.strftime('%Y%m%d%H%M%S')

execute 'Add current link' do
  command "ln -sfn /infra/deployment/word_learner/releases/#{release} current"
  cwd "/infra/deployment/word_learner/"
  user "vagrant"
  group "vagrant"
  action :run
end

execute 'Copy repo to release' do
  command "cp -r /infra/deployment/word_learner/repo /infra/deployment/word_learner/releases/#{release}"
  user "vagrant"
  action :run
end
