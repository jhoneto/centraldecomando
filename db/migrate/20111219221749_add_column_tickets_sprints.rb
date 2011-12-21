class AddColumnTicketsSprints < ActiveRecord::Migration
  def self.up   
    add_column :tickets_sprints, :estimate, :decimal, :precision => 5, :scale => 2 
  end

  def self.down      
    remove_column  :tickets_sprints, :estimate
  end
end
