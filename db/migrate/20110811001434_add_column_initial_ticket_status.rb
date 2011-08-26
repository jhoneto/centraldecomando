class AddColumnInitialTicketStatus < ActiveRecord::Migration
  def self.up
    add_column :ticket_status, :initial, :boolean
  end

  def self.down
    remove_column :ticket_status, :initial
  end
end
