class Movie < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :genres

  attr_accessible :id, :title, :release_date, :imdb_url

  def poster
    image = JSON.parse(URI.parse(URI.escape("http://www.omdbapi.com?t=#{title[0..-8]}&y=#{Date.parse(release_date).year}")).read)["Poster"]

    (image) ? Base64.encode64(URI.parse(image).read) : ""
  end
end
