class Sprint < ActiveRecord::Base
  belongs_to :project, :class_name => "Project", :foreign_key => "project_id"
end
