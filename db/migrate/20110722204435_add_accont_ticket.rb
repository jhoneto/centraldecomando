class AddAccontTicket < ActiveRecord::Migration
  def self.up
    add_column :tickets, :account_id, :integer
  end

  def self.down
    remove_column :tickets, :account_id
  end
end
