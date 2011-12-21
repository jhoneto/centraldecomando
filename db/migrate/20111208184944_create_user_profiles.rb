class CreateUserProfiles < ActiveRecord::Migration
  def self.up
    create_table :user_profiles do |t|
      t.integer    :user_id, :null => false
      t.integer    :number_columns_portlet, :default => 1, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :user_profiles
  end
end
