class User < ActiveRecord::Base
  has_many :preferences
  has_many :movies, :through => :preferences

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :id, :email, :password, :password_confirmation, :remember_me,
                  :age, :gender, :occupation, :zip

  def recommendations
    recommender = Recommender.new("EuclideanDistanceSimilarity", 3, "GenericUserBasedRecommender", false)

    rescorer = YearRescorer.new(2000)
    Movie.find(recommender.recommend_movies(id, 10, rescorer))
  end

  def rated(movie_id, rating)
    preferences.where(:item_id => movie_id, :rating => rating).any?
  end
end
