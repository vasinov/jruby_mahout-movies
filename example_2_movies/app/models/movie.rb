class Movie < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :genres

  attr_accessible :id, :title, :release_date, :rt_id, :rt_poster

  def similar_movies
    db_config = Rails.configuration.database_configuration[Rails.env]
    recommender = JrubyMahout::Recommender.new(
        "EuclideanDistanceSimilarity",
        3,
        "GenericItemBasedRecommender",
        false)
    recommender.data_model = JrubyMahout::DataModel.new("postgres", {
        :host => db_config["host"],
        :port => db_config["port"],
        :db_name => db_config["database"],
        :username => db_config["username"],
        :password => db_config["password"],
        :table_name => Preference.table_name
    }).data_model

    Movie.find(recommender.similar_items(id, 10, nil))
  end

  def plot
    begin
      JSON.parse(URI.parse(URI.escape("http://www.omdbapi.com?t=#{title}&y=#{release_date}&plot=full")).read)["Plot"]
    rescue Exception => e
      ""
    end
  end
end
