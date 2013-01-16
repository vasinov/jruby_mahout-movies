class CreateGenresMovies < ActiveRecord::Migration
  def self.up
    create_table :genres_movies, :id => false do |t|
      t.references :genre
      t.references :movie
    end
    add_index :genres_movies, [:genre_id, :movie_id]
    add_index :genres_movies, [:movie_id, :genre_id]
  end

  def self.down
    drop_table :genres_movies
  end
end
