class Sprint < ActiveRecord::Base
  belongs_to :project, :class_name => "Project", :foreign_key => "project_id"
  
  has_many :stories_sprints, :class_name => "StorySprint"
  has_many :stories, :through => :stories_sprints
  
  has_many :tickets_sprints, :class_name => "TicketSprint"
  has_many :tickets, :through => :tickets_sprints
  
end
