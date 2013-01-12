class CreatePreferences < ActiveRecord::Migration
  def self.up
    create_table :preferences do |t|
      t.references :user
      t.references :item
      t.integer :rating
      t.timestamps
    end
    add_index :preferences, :user_id, :unique => false
    add_index :preferences, :item_id, :unique => false
  end

  def self.down
    drop_table :preferences
  end
end
