class RatingsController < ApplicationController
  def index
    @ratings = Rating.all
    @top_beers=Beer.top(3)
    @top_breweries=Brewery.top(3)
    @top_users=User.top(3)
    @top_styles=Style.top(3)
    @ratings_latest=Rating.recent
  end
  def new
    @rating = Rating.new
    @beers = Beer.all
  end
  def create
    @rating=Rating.create params.require(:rating).permit(:score, :beer_id)
    if @rating.save
      current_user.ratings << @rating
      redirect_to user_path current_user
    else
      @beers=Beer.all
      render :new
    end
  end
  def destroy
    rating = Rating.find(params[:id])
    rating.delete if current_user == rating.user
    redirect_to :back
  end
  #def create
  #  rating = Rating.create params.require(:rating).permit(:score, :beer_id)
  #  session[:last_rating] = "#{rating.beer.name} #{rating.score} points"
  #  redirect_to ratings_path
  #end
end
