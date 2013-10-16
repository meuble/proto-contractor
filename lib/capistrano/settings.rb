set :rake, "/home/ror/gem/bin/rake"
set :bluepill, "/home/ror/gem/bin/bluepill"
set :gem, "/home/ror/bin/gem"

default_environment["GEM_HOME"] = "~/gem"
default_environment["RUBYLIB"] = "~/lib"
default_environment["PATH"] = "~/bin:$GEM_HOME/bin:$PATH"

# additional settings
default_run_options[:pty] = true  
set :chmod755, "app config db lib public vendor script script/* public/disp*"
set :use_sudo, false