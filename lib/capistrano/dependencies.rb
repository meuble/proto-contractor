after "deploy:setup", "baloo:gems:setup"
after "deploy:setup", "baloo:log_rotate:setup"
after "deploy:setup", "baloo:git_user:setup"

set :application_gem_list, "mysql fcgi rake"

before "sociabliz:change_asset_number" do
  run "cd #{release_path}; /home/ror/gem/bin/bundle install"
end

namespace :baloo do
  namespace :gems do
    desc "Install basic gems"
    task :setup do
      set(:current_rails_version) do
        Capistrano::CLI.ui.ask "Current rails version : "
      end
      # run "gem update --system"
      run "gem install rails -v #{current_rails_version} --no-ri --no-rdoc"
      run "gem install #{application_gem_list} --no-ri --no-rdoc"
    end
    
    desc "Install custom gems given by gems=\"gem1 gem2\""
    task :install do
      run "gem install #{ENV['gems']} --no-ri --no-rdoc"
    end
    
    desc "List installed gems"
    task :list do
      run "gem list --local"
    end
    
    desc "Install Rails bundle"
    task :install_bundle do 
      run "cd #{release_path}; /home/ror/gem/bin/bundle install --without test development"
    end
    
  end
  
  namespace :log_rotate do
    desc "Install basic gems"
    task :setup do
      run "mkdir -p /home/ror/site/prod"
      run "ln -s ../../#{application}/shared/log /home/ror/site/prod/log"
    end
  end
  
  namespace :git_user do
    desc "Setup ssh keys for the deploy user"
    task :setup do
      put File.read("#{deploy_ssh_keys_dir}id_rsa.pub"), "/home/ror/.ssh/id_rsa.pub", :via => :scp, :mode => 644
      put File.read("#{deploy_ssh_keys_dir}id_rsa"), "/home/ror/.ssh/id_rsa", :via => :scp, :mode => 600
      
      run "chmod 600 /home/ror/.ssh/id_rsa"
      run "chmod 644 /home/ror/.ssh/id_rsa.pub"
    end
  end
end
