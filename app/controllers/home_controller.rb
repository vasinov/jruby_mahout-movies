class HomeController < ApplicationController
  def index
    @movies = Movie.all(:conditions => ["release_date > ?", "2007"], :order => "random()", :limit => 100)
  end
end
