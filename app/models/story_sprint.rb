class StorySprint < ActiveRecord::Base
  belongs_to :story, :class_name => "Story", :foreign_key => "story_id"
  belongs_to :sprint, :class_name => "Sprint", :foreign_key => "sprint_id"
end
