APP_PATH = "/home/toupoutou/www/staging/"

worker_processes 2

working_directory APP_PATH + "current/"

listen "/tmp/toupoutou.staging.socket", :backlog => 64

timeout 30

pid APP_PATH + "shared/pids/unicorn.pid"

stderr_path APP_PATH + "shared/log/unicorn.stderr.log"
stdout_path APP_PATH + "shared/log/unicorn.stdout.log"
