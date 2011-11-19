class AddColumnStories < ActiveRecord::Migration
  def self.up
    add_column :stories, :account_id, :integer
    add_column :stories, :acceptance, :text
  end

  def self.down
    remove_column :stories, :account_id
    remove_column :stories, :acceptance
  end
end
