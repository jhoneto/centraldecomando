class Project < ActiveRecord::Base                            
  belongs_to :layout, :class_name => "Layout", :foreign_key => "layout_id"
  has_many :tickets
  has_many :project_members, :class_name => "ProjectMember", :foreign_key => "project_id"
  
  validates_presence_of :name
  validates_presence_of :account_id         
  
  default_scope :order => "name ASC"
    
end
