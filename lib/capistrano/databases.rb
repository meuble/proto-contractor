require 'erb'
require 'yaml'

if database_type == :mysql
  after "deploy:setup", "baloo:database:setup"
end

namespace :baloo do
  namespace :database do
    desc "Create database config file in shared path"
    task :setup, :except => { :no_release => true } do
      db_password = capture('cat .my.cnf | grep "pass = " | cut -d= -f 2').chomp
      db_username = capture('cat .my.cnf | grep "user = " | cut -d= -f 2').chomp
      db_host = capture('cat .my.cnf | grep "host = " | cut -d= -f 2').chomp
    
      db_config = ERB.new <<-EOF
production:
  adapter: mysql2
  encoding: utf8
  database: #{project}_prod
  username: #{db_username}
  password: #{db_password}
  host: #{db_host}

EOF
    
      run "mkdir -p #{shared_path}/config"
      put db_config.result, "#{shared_path}/config/database.yml", :via => :scp
      run "chmod 644 #{shared_path}/config/database.yml"
    end
  end
end