class Movie < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :genres

  attr_accessible :id, :title, :release_date, :imdb_url

  def screenshot
    Http.get(URI.escape("http://www.omdbapi.com?t=#{title[0..-8]}&y=#{Date.parse(release_date).year}"))
    #JSON.parse(Http.get(URI.escape("http://www.omdbapi.com/?t=#{title[0..-8]}&y=#{Date.parse(release_date).year}")))
  end
end
