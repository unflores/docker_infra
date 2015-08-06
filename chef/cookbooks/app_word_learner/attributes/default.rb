# Port for unicorn to communicate with webserver
default.app_word_learner.app_port = 5000

# Port for webserver to communicate with outside world
default.app_word_learner.server_port = 443

default.app_word_learner.repo = 'git@bitbucket.org:unflores/word_learner.git'
default.app_word_learner.branch = 'master'

# Base directory for everything needed to hold the app
default.app_word_learner.app_base_path = '/infra/deployment'
# SSH wrappers go here
default.app_word_learner.wrappers_path = '/infra/deployment/wrappers'
# SSH deploy keys go here
default.app_word_learner.keys_path     = '/infra/deployment/keys'
# Deploy path for the app using cap like structure
default.app_word_learner.deploy_path   = '/infra/deployment/word_learner'

