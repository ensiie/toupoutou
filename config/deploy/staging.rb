set :user, "toupoutou"
set :runner, "toupoutou"
set :use_sudo, false
set :rails_env, "staging"

set :deploy_to, "/home/toupoutou/www/staging"
set :branch, "staging"

role :web, "toupoutou.fr"
role :app, "toupoutou.fr"
role :db,  "toupoutou.fr", :primary => true

set :default_environment, {'PATH' => '$HOME/.rbenv/bin:$HOME/.rbenv/shims:$PATH'}
set :bundle_cmd, 'bundle'

set :unicorn_binary, "#{bundle_cmd} exec unicorn_rails"
set :unicorn_config, "#{current_path}/config/unicorn_staging.rb"
set :unicorn_pid, "#{current_path}/tmp/pids/unicorn.pid"


namespace :deploy do
  task :start, :roles => :app, :except => { :no_release => true } do
    run "cd #{current_path} && #{try_sudo} #{unicorn_binary} -c #{unicorn_config} -E #{rails_env} -D"
  end
  task :stop, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} kill `cat #{unicorn_pid}`"
  end
  task :graceful_stop, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} kill -s QUIT `cat #{unicorn_pid}`"
  end
  task :reload, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} kill -s USR2 `cat #{unicorn_pid}`"
  end
  task :restart, :roles => :app, :except => { :no_release => true } do
    stop
    start
  end
end