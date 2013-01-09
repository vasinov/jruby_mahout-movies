class MoviesController < ApplicationController
  def index
    @movies = Movie.first(10)
  end

  def show
    @movie = Movie.find(params[:id])
  end
end
