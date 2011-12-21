class ProjectMember < ActiveRecord::Base               
  
  belongs_to :project, :class_name => "Project", :foreign_key => "project_id"
  belongs_to :user, :class_name => "User", :foreign_key => "user_id"
  
  validates_uniqueness_of :user_id, :scope => [:project_id, :role]
end
