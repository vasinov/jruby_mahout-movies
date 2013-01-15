class YearRescorer
  java_import org.apache.mahout.cf.taste.recommender.IDRescorer

  def initialize(current_year)
    @current_year = current_year
  end

  def rescore(item_id, original_score)
    movie = Movie.find(item_id)

    (movie.release_date.to_i > @current_year) ? original_score * 1.3 : original_score
  end

  def is_filtered(item_id)
    movie = Movie.find(item_id)

    (movie.release_date.to_i < 1990) ? true : false
  end
end