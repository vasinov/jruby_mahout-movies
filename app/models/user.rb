class User < ActiveRecord::Base
  has_many :preferences
  has_many :movies, :through => :preferences

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :id, :email, :password, :password_confirmation, :remember_me,
                  :age, :gender, :occupation, :zip, :year_of_birth

  validates_presence_of :year_of_birth

  def recommendations
    user_recommender = Recommender.new("EuclideanDistanceSimilarity", 3, "GenericUserBasedRecommender", false)
    user_recommender.cached = true

    rescorer = YearRescorer.new(year_of_birth + 5)
    Movie.find(user_recommender.recommend_movies(id, 20, rescorer))
  end

  def rated(movie_id, rating)
    preferences.where(:item_id => movie_id, :rating => rating).any?
  end

  def empty_cache
    user_recommender = Recommender.new("EuclideanDistanceSimilarity", 3, "GenericUserBasedRecommender", false)
    user_recommender.cached = true
    user_recommender.recommender.redis_cache.empty!("recommendations",
                                                    { :user_id => id, :number_of_items => 20 })
  end
end
