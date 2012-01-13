class AddLayoutToProject < ActiveRecord::Migration
  def self.up             
    add_column :projects, :layout_id, :integer
  end

  def self.down                               
    remove_column :projects, :layout_id
  end
end
