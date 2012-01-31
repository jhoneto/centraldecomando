class CreateTicketHours < ActiveRecord::Migration
  def self.up
    create_table :ticket_hours do |t|
      t.integer      :ticket_id, :null => false
      t.integer      :sprint_id, :null => false
      t.date         :day, :null => false
      t.decimal      :hours_worked, :precision => 3, :scale => 1
      t.decimal      :remaining_hours, :precision => 3, :scale => 1
      t.integer      :user_id, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :ticket_hours
  end
end
