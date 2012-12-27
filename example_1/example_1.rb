require 'rubygems'
require 'bundler/setup'
require 'jruby_mahout'

recommender = JrubyMahout::Recommender.new("PearsonCorrelationSimilarity", 5, "GenericUserBasedRecommender", false)
recommender.data_model = JrubyMahout::DataModel.new("file", { :file_path => "recommender_data.csv" }).data_model

puts recommender.recommend(2, 10, nil)