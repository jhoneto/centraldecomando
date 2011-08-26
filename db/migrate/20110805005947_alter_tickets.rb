class AlterTickets < ActiveRecord::Migration
  def self.up
    remove_column :tickets, :status
    add_column :tickets, :solicitant, :string, :limit => 100
  end

  def self.down
    add_column :tickets, :status, :integer
    remove_column :tickets, :solicitant
  end
end
