class CreatePreferences < ActiveRecord::Migration
  def self.up
    create_table :preferences, :id => false do |t|
      t.references :user
      t.references :item
    end
    add_index :preferences, [:user_id, :item_id]
  end

  def self.down
    drop_table :preferences
  end
end
