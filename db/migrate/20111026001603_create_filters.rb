class CreateFilters < ActiveRecord::Migration
  def self.up
    create_table :filters do |t|
      t.string     :name, :limit => 50, :null => false
      t.string     :model, :limit => 100, :null => false
      t.integer    :user_id, :null => false
      t.string     :where, :null => false, :limit => 500
      t.timestamps
    end
  end

  def self.down
    drop_table :filters
  end
end
