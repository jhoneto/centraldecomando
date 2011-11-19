class AddColumnsToFilters < ActiveRecord::Migration
  def self.up
    add_column :filters, :columns, :string, :limit =>1000
  end

  def self.down
    remove_column :filters, :columns
  end
end
