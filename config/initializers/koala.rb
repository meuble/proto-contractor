# Monkey-patch in Facebook config so Koala knows to
# automatically use Facebook settings from here if none are given

module FacebookCredentials
  CONFIG = YAML.load_file(Rails.root.join("config/facebook.yml"))[Rails.env]
  APP_ID = CONFIG["app_id"]
  APP_SECRET = CONFIG["app_secret"]
  CALLBACK_URL  = CONFIG["callback_url"]
end

Koala::Facebook::OAuth.class_eval do
  
  def initialize_with_default_settings(*args)
    case args.size
    when 0, 1
      raise "application id and/or secret are not specified in the config" unless FacebookCredentials::APP_ID && FacebookCredentials::APP_SECRET
      initialize_without_default_settings(
        FacebookCredentials::APP_ID.to_s, 
        FacebookCredentials::APP_SECRET.to_s, 
      args.first)
    when 2, 3
      initialize_without_default_settings(*args) 
    end
  end 

  alias_method_chain :initialize, :default_settings 
end