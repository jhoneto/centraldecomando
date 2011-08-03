class CreateTicketStatus < ActiveRecord::Migration
  def self.up
    create_table :ticket_status do |t|
      t.string     :name, :limit => 100, :null => false
      t.integer    :account_id, :null => false
      t.boolean    :first, :null => false, :default => false
      t.boolean    :final, :null => false, :default => false
      t.integer    :status_prior_id
      t.integer    :status_next_id
      t.timestamps
    end
  end

  def self.down
    drop_table :ticket_status
  end
end
