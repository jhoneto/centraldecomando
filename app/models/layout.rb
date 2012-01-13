class Layout < ActiveRecord::Base
  
  has_many :layout_fields, :class_name => "LayoutField", :foreign_key => "layout_id"
  
  default_scope :order => "name asc", :conditions => { :active => 'true' }
end
