class AddFieldIdToSpecificationField < ActiveRecord::Migration
  def self.up             
    add_column :specification_fields, :layout_field_id, :integer, :null => false
  end

  def self.down                                                                 
    remove_column :specification_fields, :layout_field_id
  end
end
