class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.integer     :comment_type, :null => false
      t.text        :comment, :null => false
      t.integer     :user_id, :null => false 
      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
