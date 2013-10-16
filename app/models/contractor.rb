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
        config.consumer_key        = "RP4BAzWnz57p8UhWDnw"
        config.consumer_secret     = "HRZhqoJQHiSscR4TVvO4Eev2NlJqmK60YH5TWJ4OOA"
        config.access_token        = "731049158-w8FyLtfePtXamg3GORzdBEYWZo9Itpr191pbCqDy"
        config.access_token_secret = "kjL3MoBUqAmmSqSSnBNavEnsIXdzaORXqe14oHV6M"
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