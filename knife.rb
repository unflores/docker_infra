# See https://docs.chef.io/config_rb_knife.html for more information on knife configuration options

current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                "unflores"
client_key               "#{current_dir}/.chef/unflores.pem"
validation_client_name   "aust-validator"
validation_key           "#{current_dir}/.chef/aust-validator.pem"
chef_server_url          "https://api.opscode.com/organizations/aust"
cookbook_path            ["#{current_dir}/chef/cookbooks"]

cookbook_copyright "No Company"
cookbook_email     "me@austinflores.com"
cookbook_license   "apachev2"
