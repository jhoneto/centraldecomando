class CreateLayoutFields < ActiveRecord::Migration
  def self.up
    create_table :layout_fields do |t|
      t.integer     :layout_id, :null => false
      t.string      :label, :null => false, :limit => 100
      t.integer     :field_type, :null => false
      t.integer     :order, :null => false
      t.boolean     :visible, :null => false, :default => true
      t.timestamps
    end
  end

  def self.down
    drop_table :layout_fields
  end
end
