class CreateSpecifications < ActiveRecord::Migration
  def self.up
    create_table :specifications do |t|
      t.integer    :account_id, :null => false
      t.integer    :project_id, :null => false
      t.string     :index, :null => false, :limit => 30
      t.string     :title, :null => false, :limit => 255
      t.timestamps
    end
  end

  def self.down
    drop_table :specifications
  end
end
