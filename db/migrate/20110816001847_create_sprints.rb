class CreateSprints < ActiveRecord::Migration
  def self.up
    create_table :sprints do |t|
      t.integer    :project_id, :null => false
      t.integer    :sequence, :null => false
      t.date       :date_of_beginning, :null => false
      t.date       :date_of_end, :null => false
      t.integer    :status, :null => false
      t.integer    :capacity
      t.timestamps
    end
  end

  def self.down
    drop_table :sprints
  end
end
