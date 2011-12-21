class AddColumnFilter < ActiveRecord::Migration
  def self.up   
    add_column :filters, :show, :boolean, :default => false
  end

  def self.down            
    remove_column :filters, :show
  end
end
