class Recommender
  attr_accessor :recommender, :cached

  def initialize(similarity_name, neighborhood_size, recommender_name, is_weighted)
    db_config = Rails.configuration.database_configuration[Rails.env]
    @recommender = JrubyMahout::Recommender.new(similarity_name, neighborhood_size, recommender_name, is_weighted)

    @recommender.data_model = JrubyMahout::DataModel.new("postgres", {
        :host => db_config["host"],
        :port => db_config["port"],
        :db_name => db_config["database"],
        :username => db_config["username"],
        :password => db_config["password"],
        :table_name => Preference.table_name
    }).data_model

    @cached = false
  end

  def cached=(value)
    if @recommender.redis_cache.redis
      @recommender.redis_cache.on = value
    else
      @recommender.redis_cache = JrubyMahout::RedisCache.new($redis, value, "jmm")
    end

    @cached = value
  end

  def recommend_movies(user_id, number_of_items, rescorer)
    recommended_movies = []

    @recommender.recommend(user_id, number_of_items, rescorer).each do |recommendation|
      recommended_movies << recommendation[0]
    end

    recommended_movies
  end

  def similar_movies(item_id, number_of_items, rescorer)
    @recommender.similar_items(item_id, number_of_items, rescorer)
  end
end