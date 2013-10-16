if application_server == :thin
  after "deploy:setup", "baloo:bearstech_lighty_with_thin:setup"
else
  after "deploy:setup", "baloo:bearstech_lighty_with_fcgi:setup"
end

namespace :deploy do
  task 'start', :roles => :web do
    if application_server == :thin
      baloo.bearstech_lighty_with_thin.start
    else
      baloo.bearstech_lighty_with_fcgi.start
    end
  end 
  
  task 'restart', :roles => :web do
    if application_server == :thin
      baloo.bearstech_lighty_with_thin.restart
    else
      baloo.bearstech_lighty_with_fcgi.restart
    end
  end
end

namespace :baloo do
  namespace :bearstech_lighty_with_fcgi do
    desc <<-DESC
    Restart the application via the lighty command
    DESC
    task :restart, :roles => :app do
      run "/home/ror/bin/lighty restart"
    end
  
    desc <<-DESC
    Start the application via the lighty command
    DESC
    task :start, :roles => :app do
      run "/home/ror/bin/lighty start"
    end
  
    desc <<-DESC
    Stop the application via the lighty command
    DESC
    task :stop, :roles => :app do
      run "/home/ror/bin/lighty stop"
    end
    
    desc "setup shared folder for config files"
    task :setup, :roles => :web do
      lighty_max_proc = ENV['lighty_max_proc']

      template = File.read(File.join(File.dirname(__FILE__), 'templates', 'lighttpd_thin_sociabliz.conf.erb'))
      result = ERB.new(template).result(binding)

      put result, "/home/ror/http/lighttpd_fcgi_sociabliz.conf", :mode => 0644, :via => :scp

      run 'rm /home/ror/http/lighttpd.conf'
      run 'ln -s /home/ror/http/lighttpd_fcgi_sociabliz.conf /home/ror/http/lighttpd.conf'
    end
  end
end

namespace :baloo do
  namespace :bearstech_lighty_with_thin do
    desc <<-DESC
    Restart the application via the lighty command
    DESC
    task :restart, :roles => :app do
      run "ls /home/ror/#{application}/shared/pids/thin.*.pid | xargs tail | grep -v '==>' | xargs kill"
      run "/home/ror/gem/bin/thin start -R config.ru -C /home/ror/http/thin.yml"
      run "/home/ror/bin/lighty restart"
    end
  
    desc <<-DESC
    Start the application via the lighty command
    DESC
    task :start, :roles => :app do
      run "/home/ror/gem/bin/thin start -R config.ru -C /home/ror/http/thin.yml"
      run "/home/ror/bin/lighty start"
    end
  
    desc <<-DESC
    Stop the application via the lighty command
    DESC
    task :stop, :roles => :app do
      run "ls /home/ror/#{application}/shared/pids/thin.*.pid | xargs tail | grep -v '==>' | xargs kill"
      run "/home/ror/bin/lighty stop"
    end
    
    desc "setup shared folder for config files"
    task :setup, :roles => :web do
      template = File.read(File.join(File.dirname(__FILE__), 'templates', 'lighttpd_thin_sociabliz.conf.erb'))
      result = ERB.new(template).result(binding)

      put result, "/home/ror/http/lighttpd_thin_sociabliz.conf", :mode => 0644, :via => :scp
      
      run 'rm /home/ror/http/lighttpd.conf'
      run 'ln -s /home/ror/http/lighttpd_thin_sociabliz.conf /home/ror/http/lighttpd.conf'
    end
  end
end