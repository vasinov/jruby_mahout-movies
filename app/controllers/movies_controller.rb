class MoviesController < ApplicationController
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

    current_user.empty_cache

    respond_to do |format|
      format.html { redirect_to (@movie), :notice => 'You rated a movie.' }
      format.json { render :json => {:message => 'OK' } }
    end
  end
end
