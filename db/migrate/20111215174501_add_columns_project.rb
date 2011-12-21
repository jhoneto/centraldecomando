class AddColumnsProject < ActiveRecord::Migration
  def self.up 
    add_column :projects, :qty_sprint_days, :integer
    add_column :projects, :start_sprint, :integer
    add_column :projects, :include_saturday, :boolean
    add_column :projects, :include_sunday, :boolean
  end

  def self.down
    remove_column :projects, :qty_sprint_days
    remove_column :projects, :start_sprint
    remove_column :projects, :include_saturday
    remove_column :projects, :include_sunday
  end
end
