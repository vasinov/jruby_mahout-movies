class AddScoreToMovies < ActiveRecord::Migration
  def up
    change_table :movies do |t|
      t.integer :rt_critics_score
    end
  end

  def down
    remove_column :movies, :rt_critics_score
  end
end
