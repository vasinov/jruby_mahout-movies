class AddRatingToPreferences < ActiveRecord::Migration
  def up
    change_table :preferences do |t|
      t.integer :rating
    end
  end

  def down
    remove_column :preferences, :rating
  end
end
