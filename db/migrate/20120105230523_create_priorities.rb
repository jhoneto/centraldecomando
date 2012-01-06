class CreatePriorities < ActiveRecord::Migration
  def self.up
    create_table :priorities do |t|
      t.integer     :account_id, :null => false
      t.string      :name, :null => false 
      t.integer     :value, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :priorities
  end
end
