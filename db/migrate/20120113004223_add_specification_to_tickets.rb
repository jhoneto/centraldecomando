class AddSpecificationToTickets < ActiveRecord::Migration
  def self.up
    add_column :tickets, :specification_id, :integer
  end

  def self.down                           
    remove_column :tickets, :specification_id
  end
end
