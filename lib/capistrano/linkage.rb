after "deploy:finalize_update", "baloo:link_database"
after "deploy:finalize_update", "baloo:link_facebook_config"
after "deploy:finalize_update", "baloo:createtemp"

namespace :baloo do

  desc "create shared sockets directory"
  task :createtemp, :roles => :app, :except => {:no_release => true} do
    run "mkdir -p #{shared_path}/sockets && chmod 777 #{shared_path}/sockets"
		run "ln -nfs #{shared_path}/sockets #{release_path}/tmp/sockets"
  end
  
  desc "create link to database config file"
  task :link_facebook_config, :roles => :app, :except => {:no_release => true} do
		run "ln -nfs #{shared_path}/config/facebook.yml #{release_path}/config/facebook.yml"
  end
  
  desc "create link to database config file"
  task :link_database, :roles => :app, :except => {:no_release => true} do
		run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
end
