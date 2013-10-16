if application_server == :thin
  after "deploy:setup", "baloo:thin:setup"
end

namespace :baloo do
  namespace :thin do
    desc "setup thin configuration file"
    task :setup, :roles => :web do
      run "gem install thin --no-ri --no-rdoc"
      template = File.read(File.join(File.dirname(__FILE__), 'templates', 'thin_configuration.yml.erb'))
      result = ERB.new(template).result(binding)

      put result, "/home/ror/http/thin.yml", :mode => 0644, :via => :scp
    end
  end
end