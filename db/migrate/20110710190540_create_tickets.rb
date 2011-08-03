class CreateTickets < ActiveRecord::Migration
  def self.up
    create_table :tickets do |t|
      t.string     :title, :null => false, :limit => 500
      t.text       :description
      t.integer    :status, :null => false
      t.integer    :project_id
      t.integer    :client_id
      t.date       :date_of_registration, :null => false
      t.date       :cancellation_date
      t.date       :closing_date
      t.integer    :user_registration_id
      t.integer    :user_owner_id 
      t.timestamps
    end
  end

  def self.down
    drop_table :tickets
  end
end
