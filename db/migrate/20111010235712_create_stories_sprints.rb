class CreateStoriesSprints < ActiveRecord::Migration
  def self.up
    create_table :stories_sprints do |t|
      t.integer    :story_id, :null => false
      t.integer    :sprint_id, :null => false
      t.boolean    :closed, :null => false, :default => false
      t.timestamps
    end
  end

  def self.down
    drop_table :stories_sprints
  end
end
