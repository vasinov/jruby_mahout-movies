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

    Movie.find(recommender.recommend(id, 10, nil))
  end
end
