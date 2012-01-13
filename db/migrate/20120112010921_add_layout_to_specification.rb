class AddLayoutToSpecification < ActiveRecord::Migration
  def self.up           
    add_column :specifications, :layout_id, :integer, :null => false
  end

  def self.down                                                     
    remove_column :specfications, :layout_id
  end
end
