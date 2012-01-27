class AddEstimatedToSprint < ActiveRecord::Migration
  def self.up
    add_column :sprints, :estimated, :decimal, :precision => 5, :scale => 2
  end

  def self.down
    remove_column :sprints, :estimated
  end
end
