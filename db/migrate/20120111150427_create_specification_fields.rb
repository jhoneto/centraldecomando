class CreateSpecificationFields < ActiveRecord::Migration
  def self.up
    create_table :specification_fields do |t|
      t.integer     :specification_id, :null => false
      t.string      :label, :null => false, :limit => 100
      t.integer     :field_type, :null => false
      t.integer     :order, :null => false
      t.string      :value_text
      t.text        :value_memo
      t.decimal     :value_number
      t.date        :value_date
      t.boolean     :value_boolean
      t.timestamps
    end
  end

  def self.down
    drop_table :specification_fields
  end
end
