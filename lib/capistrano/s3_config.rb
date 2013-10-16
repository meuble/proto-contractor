require 'erb'
require 'yaml'

namespace :baloo do
  namespace :s3 do
    desc "Create s3 config file in shared path"
    task :setup, :except => { :no_release => true } do
      set(:s3_access_key_id) do
        Capistrano::CLI.ui.ask "S3 Access Key ID : "
      end
      set(:s3_secret_access_key) do
        Capistrano::CLI.ui.ask "S3 Secret Access Key : "
      end
      set(:s3_bucket_name) do
        Capistrano::CLI.ui.ask "Bucket Name : "
      end
      
      db_config = ERB.new <<-EOF
production: 
  access_key_id: #{s3_access_key_id}
  secret_access_key: #{s3_secret_access_key}
  bucket_name: #{s3_bucket_name}

EOF
      run "mkdir -p #{shared_path}/config"
      put db_config.result, "#{shared_path}/config/amazon_s3.yml", :via => :scp
      run "chmod 644 #{shared_path}/config/amazon_s3.yml"
    end
    
    desc "create link to s3 config file"
    task :link, :roles => :app, :except => {:no_release => true} do
  		run "ln -nfs #{shared_path}/config/amazon_s3.yml #{release_path}/config/amazon_s3.yml"
    end
  end
end