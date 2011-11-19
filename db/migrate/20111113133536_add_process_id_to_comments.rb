class AddProcessIdToComments < ActiveRecord::Migration
  def self.up
    add_column :comments, :process_id, :integer, :null => false
  end

  def self.down
    remove_column :comments, :process_id
  end
end
