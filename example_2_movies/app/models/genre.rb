class Genre < ActiveRecord::Base
  has_and_belongs_to_many :movies

  attr_accessible :title, :release_date, :imdb_url
end
