require 'erb'
require 'yaml'

after "deploy:setup", "baloo:facebook:setup"

namespace :baloo do
  namespace :facebook do
    desc "Create baloo config file in shared path"
    task :setup, :except => { :no_release => true } do
      callback_url = "http://#{application}/"
      set(:facebook_api_key) do
        Capistrano::CLI.ui.ask "Facebook API key : "
      end
      set(:facebook_app_id) do
        Capistrano::CLI.ui.ask "Facebook Application ID : "
      end
      set(:facebook_canvas_page_name) do
        Capistrano::CLI.ui.ask "Facebook Canvas page name : "
      end
      set(:facebook_secret) do
        Capistrano::CLI.ui.ask "Facebook Secret key : "
      end
      
      db_config = ERB.new <<-EOF
production: 
  callback_url: #{callback_url}
  api_key: #{facebook_api_key}
  last_commit_id: 0
  app_id: #{facebook_app_id}
  canvas_page_name: #{facebook_canvas_page_name}
  secret: #{facebook_secret}
  adapter: koala

EOF
    
      run "mkdir -p #{shared_path}/config"
      put db_config.result, "#{shared_path}/config/baloo.yml", :via => :scp
      run "chmod 644 #{shared_path}/config/baloo.yml"
    end
  end
end