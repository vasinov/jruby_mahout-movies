require 'csv'
require 'date'

namespace :precache do
  desc "Precaches movie similarities into Redis"
  task :item_similarities, [:number_of_items] => :environment do |t, args|
  args.with_defaults(:number_of_items => 10)
    begin
      puts "Precaching movie similarities..."

      movies = Movie.all
      count = 0
      number_of_items = args.number_of_items

      movies.each_with_index do |movie, i|
        movie_recommender = Recommender.new("EuclideanDistanceSimilarity", 3, "GenericItemBasedRecommender", false)
        movie_recommender.cached = true
        rescorer = GenreRescorer.new(movie.genres.map(&:id))

        movie_recommender.recommender.redis_cache.empty!("similar_items",
                                                        { :item_id => movie.id, :number_of_items => number_of_items })

        movie_recommender.similar_movies(movie.id, number_of_items, rescorer)

        count = i + 1
      end

      puts "#{count} movies precached"
    rescue Exception => e
      puts e
    end
  end

  desc "Precaches recommendations for users into Redis"
  task :user_recommendations, [:number_of_items] => :environment do |t, args|
    args.with_defaults(:number_of_items => 10)
    begin
      puts "Precaching recommendations for users..."

      users = User.all
      count = 0
      number_of_items = args.number_of_items

      users.each_with_index do |user, i|
        user_recommender = Recommender.new("EuclideanDistanceSimilarity", 3, "GenericUserBasedRecommender", false)
        user_recommender.cached = true
        rescorer = YearRescorer.new(2000)

        user_recommender.recommender.redis_cache.empty!("recommendations",
                                                         { :user_id => user.id, :number_of_items => number_of_items })

        user_recommender.recommend_movies(user.id, 10, rescorer)

        count = i + 1
      end

      puts "#{count} recommendations for users precached"
    rescue Exception => e
      puts e
    end
  end
end