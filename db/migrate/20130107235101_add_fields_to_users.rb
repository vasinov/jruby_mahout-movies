class AddFieldsToUsers < ActiveRecord::Migration
  def up
    change_table :users do |t|
      t.integer :age
      t.string :gender
      t.string :occupation
      t.integer :zip
    end
  end

  def down
    remove_column :users, :age
    remove_column :users, :gender
    remove_column :users, :occupation
    remove_column :users, :zip
  end
end
