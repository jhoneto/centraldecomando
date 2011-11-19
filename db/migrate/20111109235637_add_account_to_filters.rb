class AddAccountToFilters < ActiveRecord::Migration
  def self.up
    add_column :filters, :account_id, :integer
  end

  def self.down
    remove_column :filters, :account_id
  end
end
