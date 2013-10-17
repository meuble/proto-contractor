# coding: utf-8
class User < ActiveRecord::Base

  attr_accessible :twitter_id, :facebook_id

  validates :twitter_id, uniqueness: true, if: :twitter_id?
  validates :facebook_id, uniqueness: true, if: :facebook_id?
  validate :validates_any_uid
  
  def validates_any_uid
    self.errors.add(:base, "Uid est vide") if self.twitter_id.blank? && self.facebook_id.blank?
  end

  def uid
    self.facebook_id.present? ? 
      self.facebook_id : 
      self.twitter_id
  end
  
  def provider
    self.facebook_id.present? ? :facebook : :twitter
  end
  
  def icon
    "#{self.provider}.png"
  end
  
end
