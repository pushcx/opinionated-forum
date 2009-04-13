  class User < ActiveRecord::Base
  has_many :posts
  has_many :viewings, :dependent => :delete_all
  has_many :viewed_topics, :through => :viewings, :source => :topic

  validates_presence_of :openid_url
  validates_presence_of :name
  validates_uniqueness_of :name, :case_sensitive => false

  is_gravtastic :rating => 'R', :size => 30

  def mark_all_topics_read
    # set the time marker
    update_attribute(:all_read_upto, Time.now.utc)

    # and do some housekeeping
    viewings.clear
  end
end
