class HomeController < ApplicationController
  def index
    @movies = Movie.first(10)
  end
end
