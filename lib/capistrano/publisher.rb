# #coding: utf-8
# require "pony"
# GIT_USER_EMAIL = "git config --get user.email"
# 
# namespace :sbz do 
#   task :publish, :roles => :web do 
#     # retrieve smtp_config and symbolize keys for :via_options
#     publisher_options, symbolized_smtp_options = YAML::load(File.open(ENV['SOCIABLIZ_CONFIG'] || "#{ENV["HOME"]}/.sociabliz.yml"))["publisher"], {}
#     publisher_options["smtp_options"].map {|k, v| symbolized_smtp_options[k.to_sym] = v}
#     # send the message
#     mail = {
#       :from => "git" == publisher_options["from"] ? `#{GIT_USER_EMAIL}`.strip! : publisher_options["from"],
#       :to => publish_to,
#       :subject => "euh oais ##{project} #release",
#       :body => body,
#       :via => :smtp,
#       :via_options => symbolized_smtp_options
#     }
#     puts Pony.mail(mail)
#   end
# end