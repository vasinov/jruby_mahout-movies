class Movie < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :genres

  attr_accessible :id, :title, :release_date, :imdb_url
end
