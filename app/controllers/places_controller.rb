class PlacesController < ApplicationController
  before_action :set_place, only: [:show]
  
  def index
  end

  def search
    session[:city]=params[:city]
    @places=BeermappingApi.places_in(params[:city])
    if @places.empty?
      redirect_to places_path, notice: "No locations in #{params[:city]}"
    else
    render :index
    #@places1=@places
    end
  end

  def show
    #@place =@places.find {|s| s.name.eql? "Pullman Bar"}

  end

    def set_place
      @places=BeermappingApi.places_in(session[:city])
      @place = @places.find{|s| s.id == params[:id]}
      #render :index
    end

end
