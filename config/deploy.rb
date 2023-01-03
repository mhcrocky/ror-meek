set :default_environment, {
                            'PATH' => "$HOME/.rbenv/shims:$HOME/.rbenv/bin:/opt/rbenv/shims:/opt/rbenv/bin:$PATH"
                        }

set :rbenv_ruby, '3.1.2'
set :application, 'meek'
set :repo_url, 'git@gitlab.anahoret.com:mab/meek.git'
set :git_shallow_clone, 1
set :deploy_via, :copy
set :group_writable, false

set :tag_deploy_commit, false

set :normalize_asset_timestamps, false
set :disable_web_during_migrations, true

set :bundle_without, %w(development test cucumber).join(' ')

set :bundle_flags, "--deployment --quiet"

set :resque_log_file, 'log/resque.log'
set :resque_verbose, true
set :resque_pid_path, -> { File.join(shared_path, 'pids') }
set :resque_environment_task, true

namespace :deploy do
  desc 'Start application.'
  task :start do
    on roles(:app) do
      execute 'sudo service meek start'
    end
  end

  desc 'Stop application.'
  task :stop do
    on roles(:app) do
      execute 'sudo service meek stop'
    end
  end

  desc 'Restart application.'
  task :restart do
    on roles(:app) do
      execute 'sudo service meek restart'
    end
  end
end

namespace :db do
  desc 'Make symlinks'
  task :symlink do
    on roles(:app) do
      execute "ln -nfs #{shared_path}/config/secrets.yml #{release_path}/config/secrets.yml"
      execute "ln -nfs #{shared_path}/public/system/ #{release_path}/public/"

      execute "ln -nfs #{shared_path}/public/js      #{release_path}/public/"
      execute "ln -nfs #{shared_path}/public/css     #{release_path}/public/"
      execute "ln -nfs #{shared_path}/public/fonts   #{release_path}/public/"
      execute "ln -nfs #{shared_path}/public/assets  #{release_path}/public/"
    end
  end
end

namespace :bower do
  desc 'Install bower'
  task :install do
    on roles(:web) do
      within release_path do
        execute :rake, 'bower:install CI=true'
      end
    end
  end
end

after 'deploy:updating', 'db:symlink'
after 'deploy:finished', 'deploy:restart'
after 'deploy:finished', 'resque:restart'
