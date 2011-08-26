class AlterTipoSequenceSprint < ActiveRecord::Migration
  def self.up
    change_column :sprints, :sequence, :string
  end

  def self.down
    change_column :sprints, :sequence, :integer
  end
end