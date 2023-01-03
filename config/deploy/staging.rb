role :app,            %w{deploy@104.236.5.233}
role :web,            %w{deploy@104.236.5.233}
role :db,             %w{deploy@104.236.5.233}
role :resque_worker,  %w{deploy@104.236.5.233}

set :branch, 'staging'
set :host,   '104.236.5.233'
set :user,   'deploy'
set :deploy_to, "/var/www/apps/meek"
