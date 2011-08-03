class CreateClients < ActiveRecord::Migration
  def self.up
    create_table :clients do |t|
      t.string     :name, :null => false
      t.integer    :account_id, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :clients
  end
end
