class AddTicketTypeInTicket < ActiveRecord::Migration
  def self.up
    add_column :tickets, :ticket_type_id, :integer
  end

  def self.down
    remove_column :tickets, :ticket_type_id
  end
end
