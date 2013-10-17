require "twitter"

class Contractor
    
  def self.notify(message)
    User.all.each do |user|
      if user.provider == :facebook
        Contractor::Faceboobs.notify(user.uid, message)
      elsif user.provider == :twitter
        Contractor::Twittos.notify(user.uid, message)
      end
    end
    
  end
  
  module Faceboobs

    def self.graph
      @graph ||= Koala::Facebook::API.new(self.get_app_access_token)
    end

    def self.get_app_access_token
      self.oauth.get_app_access_token
    end
    
    def self.oauth
      @oauth ||= Koala::Facebook::OAuth.new(FacebookCredentials::APP_ID, FacebookCredentials::APP_SECRET, FacebookCredentials::CALLBACK_URL)
    end
    
    def self.notify(recipient, message)
      self.graph.put_connections(recipient, "notifications", 
        href: "http://proto-contractor.herokuapp.com", 
        template: message, 
        ref: "reply_notif"
      )
    end
  
  end
  
  module Twittos
    
    
    def self.notify(recipient, message)
      self.client.dm(recipient, message)
    end

    def self.client
      client = Twitter::REST::Client.new do |config|
        config.consumer_key        = "ITF2qtoraP3ZZtBOhkoi5w"
        config.consumer_secret     = "Olth8UjwpP0RjS8p9aHVrPjFqAvJSVZlB9y4RZNb1E"
        config.access_token        = "1966626704-RNYR8hJfOAyYC8DiFJWRQnbLxRCBDh7vVJJOxe9"
        config.access_token_secret = "tcHpawC9zTD9NvWxhndY0XLirn6doC3Es3MzLgvWKs"
      end
    end
  
    def self.is_followed_by?(twitter_uid)
      @followers ||= self.client.followers.attrs[:users]
      @followers.each do |follower|
        return true if follower[:screen_name] == twitter_uid
      end
      false
    end
    
  end
  
  
end