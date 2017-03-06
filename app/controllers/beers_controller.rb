class BeersController < ApplicationController
  before_action :skip_if_cached, only:[:index]
  #before_action :ensure_that_signed_in, except: [:index, :show, :list]
  before_action :set_beer, only: [:show, :edit, :update, :destroy]

  def list
  end
  # GET /beers
  # GET /beers.json
  def index
    @beers = Beer.includes(:brewery, :style).all
    #@beers = Beer.all
    
    order=params[:order] || 'name'

    @beers=case @order
      when 'name' then
       if session[:clicks_n]==1
          session[:clicks_n]=0
          @beers.sort_by{|b| b.name}.reverse

        else
          session[:clicks_n]=1 
          @beers.sort_by{|b| b.name}

        end      
      when 'brewery' then 
       if session[:clicks_b]==1
          session[:clicks_b]=0
          @beers.sort_by{|b| b.brewery.name}.reverse
        else
          session[:clicks_b]=1
          @beers.sort_by{|b| b.brewery.name}
        end
      when 'style' then 
       if session[:clicks_b]==1
          session[:clicks_b]=0
          @beers.sort_by{|b| b.style.name}.reverse
       else
          session[:clicks_b]=1
          @beers.sort_by{|b| b.style.name}
       end
    end
  end

  # GET /beers/1
  # GET /beers/1.json
  def show
    @rating=Rating.new
    @rating.beer=@beer
  end

  # GET /beers/new
  def new
    @beer = Beer.new
    @breweries=Brewery.all
    @styles = Style.all
  end

  # GET /beers/1/edit
  def edit
    @breweries = Brewery.all
    @styles = ["Weizen", "Lager", "Pale ale", "IPA", "Porter"]
  end

  # POST /beers
  # POST /beers.json
  def create
    expire_fragment('beerlist')
    @beer = Beer.new(beer_params)

    respond_to do |format|
      if @beer.save
       format.html { redirect_to beers_path, notice: 'Beer was successfully created.' }
        format.json { render :show, status: :created, location: @beer }
      else
        @breweries = Brewery.all
        @styles = Style.all
        format.html { render :new }
        format.json { render json: @beer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /beers/1
  # PATCH/PUT /beers/1.json
  def update
    expire_fragment('beerlist')
    respond_to do |format|
      if @beer.update(beer_params)
        format.html { redirect_to @beer, notice: 'Beer was successfully updated.' }
        format.json { render :show, status: :ok, location: @beer }
      else
        format.html { render :edit }
        format.json { render json: @beer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /beers/1
  # DELETE /beers/1.json
  def destroy
    expire_fragment('beerlist')
    if current_user.admin
    @beer.destroy
    respond_to do |format|
      format.html { redirect_to beers_url, notice: 'Beer was successfully destroyed.' }
      format.json { head :no_content }
    end
    else
    respond_to do |format|
      format.html { redirect_to beers_url, notice: 'You need to be admin for this operation' }
      format.json { head :no_content }
    end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_beer
      @beer = Beer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def beer_params
      params.require(:beer).permit(:name, :style, :brewery_id)
    end
  def skip_if_cached
    @order=params[:order] || 'name'
    return render :index if fragment_exist?( "beerlist-#{@order}" )
  end
end
