class AddPriorityToTicket < ActiveRecord::Migration
  def self.up            
    add_column :tickets, :priority_id, :integer
  end

  def self.down                                
    remove_column :tickets, :priority
  end
end
