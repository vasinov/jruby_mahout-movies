class AddTimestampsToPreferences < ActiveRecord::Migration
  def up
    change_table :preferences do |t|
      t.timestamps
    end
  end

  def down
    remove_column :preferences, :created_at
    remove_column :preferences, :updated_at
  end
end
