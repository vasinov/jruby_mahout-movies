class Movie < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :genres

  attr_accessible :id, :title, :release_date, :rt_id, :rt_poster

  validates_presence_of :title

  def similar_movies
    movie_recommender = Recommender.new("EuclideanDistanceSimilarity", 3, "GenericItemBasedRecommender", false)
    movie_recommender.cached = true

    rescorer = GenreRescorer.new(genres.map(&:id))
    Movie.find(movie_recommender.similar_movies(id, 10, rescorer))
  end

  def plot
    begin
      JSON.parse(URI.parse(URI.escape("http://www.omdbapi.com?t=#{title}&y=#{release_date}&plot=full")).read)["Plot"]
    rescue Exception => e
      ""
    end
  end
end
