class CreateLayouts < ActiveRecord::Migration
  def self.up
    create_table :layouts do |t|
      t.integer    :account_id, :null => false
      t.string     :name, :null => false, :limit => 100
      t.boolean    :active, :null => false
      t.integer    :layout_type, :null => false, :default => 1
      t.timestamps
    end
  end

  def self.down
    drop_table :layouts
  end
end
