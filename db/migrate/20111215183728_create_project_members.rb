class CreateProjectMembers < ActiveRecord::Migration
  def self.up
    create_table :project_members do |t|
      t.integer     :project_id, :null => false
      t.integer     :user_id, :null => false
      t.integer     :role, :null => false
      t.decimal     :week_hours, :precision => 5, :scale => 2
      t.timestamps
    end
  end

  def self.down
    drop_table :project_members
  end
end
