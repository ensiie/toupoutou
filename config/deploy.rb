set :application, "toupoutou"
set :repository,  "git@github.com:ensiie/toupoutou"

set :scm, :git

set :normalize_asset_timestamps, false

ssh_options[:forward_agent] = true

require 'capistrano/ext/multistage'
require 'bundler/capistrano'

after "deploy:setup", "symlinks:mkdir"
after "deploy:update_code", "symlinks:db"
after "deploy", "deploy:cleanup"

namespace :symlinks do
  desc "Symlink database config file"
  task :db do
    run "ln -nfs #{shared_path}/config/mongoid.yml #{current_release}/config/mongoid.yml"
  end

  desc "Create dirs"
  task :mkdir do
    run "mkdir -p #{shared_path}/config"
  end
end

require './config/boot'
