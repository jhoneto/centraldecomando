class CreateStories < ActiveRecord::Migration
  def self.up
    create_table :stories do |t|
      t.string     :as_a, :limit => 100, :null => false
      t.text       :i_want_to, :null => false
      t.text       :so_that_i
      t.integer    :project_id, :null => false
      t.integer    :complexity
      t.integer    :priority
      t.timestamps
    end
  end

  def self.down
    drop_table :stories
  end
end
