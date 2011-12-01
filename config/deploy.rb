set :application, "toupoutou"
set :repository,  "git@github.com:ensiie/toupoutou"

set :scm, :git

set :normalize_asset_timestamps, false

ssh_options[:forward_agent] = true

require 'capistrano/ext/multistage'
require 'bundler/capistrano'

after "deploy:setup", "symlinks:mkdir"
after "deploy:update_code", "symlinks:db", "symlinks:omniauth_config", "assets:precompile"
after "deploy", "deploy:restart_workers", "deploy:cleanup"

namespace :symlinks do
  desc "Symlink database config file"
  task :db do
    run "ln -nfs #{shared_path}/config/mongoid.yml #{current_release}/config/mongoid.yml"
  end

  task :omniauth_config do
    run "ln -nfs #{shared_path}/config/omniauth_configs.yml #{current_release}/config/omniauth_configs.yml"
  end

  desc "Create dirs"
  task :mkdir do
    run "mkdir -p #{shared_path}/config"
  end
end

namespace :deploy do
  desc "Restart Resque Workers"
  task :restart_workers, :roles => :app do
    rake = fetch(:rake, "rake")
    rails_env = fetch(:rails_env, "production")
    run "cd #{current_path} && SHARED_PATH=#{shared_path} RAILS_ENV=#{rails_env} RAILS_ROOT=#{current_path} bundle exec god -c resque.god restart"
  end
end

namespace :assets do
  desc "Precompile assets"
  task :precompile do
    run "cd #{release_path}; RAILS_ENV=#{rails_env} #{bundle_cmd} exec rake assets:precompile"
  end
end

require './config/boot'
