class GenreRescorer
  java_import org.apache.mahout.cf.taste.recommender.IDRescorer

  def initialize(current_genres)
    @current_genres = current_genres
  end

  def rescore(item_id, original_score)
    movie = Movie.find(item_id.getSecond)

    (movie.genres.exists?(:id => @current_genres)) ? original_score * 1.3 : original_score
  end

  def is_filtered(item_id)
    movie = Movie.find(item_id.getSecond)

    (movie.release_date.to_i < 1995) ? true : false
  end
end