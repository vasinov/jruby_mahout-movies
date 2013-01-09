class Movie < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :genres

  attr_accessible :id, :title, :release_date, :imdb_url

  def similar_movies
    db_config = Rails.configuration.database_configuration[Rails.env]
    recommender = JrubyMahout::Recommender.new(
        "PearsonCorrelationSimilarity",
        5,
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

    Movie.find(recommender.similar_items(id, 5, nil))
  end

  def poster
    begin
      image = JSON.parse(URI.parse(URI.escape("http://www.omdbapi.com?t=#{title[0..-8]}&y=#{Date.parse(release_date).year}")).read)["Poster"]

      (image) ? Base64.encode64(URI.parse(image).read) : ""
    rescue Exception => e
      ""
    end
  end

  def plot
    begin
      JSON.parse(URI.parse(URI.escape("http://www.omdbapi.com?t=#{title[0..-8]}&y=#{Date.parse(release_date).year}&plot=full")).read)["Plot"]
    rescue Exception => e
      ""
    end
  end
end
