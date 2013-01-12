class MoviesController < ApplicationController
  def index
    @movies = Movie.first(10)
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def rate
    @movie = Movie.find(params[:id])
    rating = params[:rating]

    preference = current_user.preferences.find_or_initialize_by_item_id(@movie.id) do |p|
      p.rating = rating
    end

    preference.rating = rating
    preference.save!

    respond_to do |format|
      format.html { redirect_to (@movie), :notice => 'You rated a movie.' }
    end
  end
end
