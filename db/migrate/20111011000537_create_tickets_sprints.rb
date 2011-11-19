class CreateTicketsSprints < ActiveRecord::Migration
  def self.up
    create_table :tickets_sprints do |t|
      t.integer    :ticket_id, :null => false
      t.integer    :sprint_id, :null => false
      t.boolean    :closed, :null => false, :default => false
      t.timestamps
    end
  end

  def self.down
    drop_table :tickets_sprints
  end
end
