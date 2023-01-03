role :app,           %w{deploy@159.203.117.170}
role :web,           %w{deploy@159.203.117.170}
role :db,            %w{deploy@159.203.117.170}
role :resque_worker, %w{deploy@159.203.117.170}

set :branch, 'release_09'
set :host,   '159.203.117.170'
set :user,   'deploy'
set :deploy_to, "/var/www/apps/meek"
