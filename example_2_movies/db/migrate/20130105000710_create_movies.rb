class CreateMovies < ActiveRecord::Migration
  def up
    create_table :movies do |t|
      t.string :title
      t.string :release_date
      t.text :imdb_url

      t.timestamps
    end
  end

  def down
    drop_table :movies
  end
end
