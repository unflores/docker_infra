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

include_recipe 'app_word_learner::build_repo'

include_recipe 'app_word_learner::build_app_docker'

include_recipe 'app_word_learner::build_webserver_docker'
