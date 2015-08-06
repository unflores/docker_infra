name "dev_box"
description "This box contains everything necessary for a self-standing dev box"
run_list "recipe[system::default]", "recipe[app_word_learner::default]"
default_attributes system: { user: :vagrant }
