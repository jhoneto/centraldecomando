class Comment < ActiveRecord::Base
  
  belongs_to :user, :class_name => "User", :foreign_key => "user_id"
  
  validates_presence_of :comment, :on => :create, :message => "can't be blank"
end
