class AddYearOfBirthToUsers < ActiveRecord::Migration
  def up
    change_table :users do |t|
      t.integer :year_of_birth
    end
  end

  def down
    remove_column :users, :year_of_birth
  end
end
