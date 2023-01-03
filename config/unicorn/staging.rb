# set path to app that will be used to configure unicorn,
# note the trailing slash in this example
@dir = "/var/www/apps/meek/current/"

worker_processes 2
working_directory @dir

timeout 150

# Specify path to socket unicorn listens to,
# we will use this in our nginx.conf later
listen "/tmp/unicorn.meek.sock", :backlog => 64

# Set process id path
pid "/var/www/apps/meek/shared/pids/unicorn.pid"

# Set log file paths
stderr_path "#{@dir}log/unicorn.stderr.log"
stdout_path "#{@dir}log/unicorn.stdout.log"
