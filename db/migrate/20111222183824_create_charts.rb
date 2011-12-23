class CreateCharts < ActiveRecord::Migration
  def self.up
    create_table :charts do |t|
      t.string      :name, :limit => 100, :null => false
      t.integer     :account_id, :null => false
      t.integer     :chart_type, :null => false
      t.string      :model, :limit => 50, :null => false
      t.string      :params, :limit => 500
      t.string      :method, :limit => 50, :null => false
      t.integer     :user_id, :null => false
      t.boolean     :show, :default => false, :null => false
      t.boolean     :sidebar, :default => false, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :charts
  end
end
