class User < ActiveRecord::Base
  has_many :preferences
  has_many :movies, :through => :preferences

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :id, :email, :password, :password_confirmation, :remember_me,
                  :age, :gender, :occupation, :zip

  def recommendations
    db_config = Rails.configuration.database_configuration[Rails.env]
    recommender = JrubyMahout::Recommender.new(
        "EuclideanDistanceSimilarity",
        3,
        "GenericUserBasedRecommender",
        false)
    recommender.data_model = JrubyMahout::DataModel.new("postgres", {
        :host => db_config["host"],
        :port => db_config["port"],
        :db_name => db_config["database"],
        :username => db_config["username"],
        :password => db_config["password"],
        :table_name => Preference.table_name
    }).data_model

    recommended_movies = []

    recommender.recommend(id, 10, nil).each do |recommendation|
      recommended_movies << recommendation[0]
    end

    Movie.find(recommended_movies)
  end
end
