require 'hpricot'
require 'open-uri'

class MoviesController < ApplicationController
  # GET /movies
  # GET /movies.xml
  def index
    @movies = Movie.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @movies }
    end
  end

  # GET /movies/1
  # GET /movies/1.xml
  def show
    @movie = Movie.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @movie }
    end
  end
  
  def search
    respond_to do |format|
      format.html #search.html.erb
      format.xml
    end
  end
  
  def add
    respond_to do |format|
      if params[:movieChoice] or true
        @movie = Movie.new
        @movie.title = params[:title]
        @movie.description = params[:description]
        @movie.score = params[:score]
        @movie.rating = params[:rating]
        @movie.released_on = params[:released_on]
        if @movie.save
          format.html { redirect_to(movies_url()) }
          format.xml
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @movie.errors, :status => :unprocessable_entity }
        end
      else
        format.html { redirect_to(movies_url, :notice=>'No movie selected') }
        format.xml
      end
    end
  end

  def results
    respond_to do |format|
      someId = self.getData(params[:title])
      @movie = Movie.new
      if someId
        format.html #search.html.erb
        format.xml
      else
        format.html {redirect_to(search_path(), :notice=>'No movies found')}
        format.xml
      end
    end
  end
  
  # GET /movies/new
  # GET /movies/new.xml
  def new
    @movie = Movie.new
    if(params[:choice])
      @movie = Move.find(params[:choice])
    end
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @movie }
    end
  end

  # GET /movies/1/edit
  def edit
    @movie = Movie.find(params[:id])
  end

  # POST /movies
  # POST /movies.xml
  def create
    @movie = Movie.new(params[:movie])

    respond_to do |format|
      if @movie.save
        format.html { redirect_to(@movie, :notice => 'Movie was successfully created.') }
        format.xml  { render :xml => @movie, :status => :created, :location => @movie }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @movie.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /movies/1
  # PUT /movies/1.xml
  def update
    @movie = Movie.find(params[:id])

    respond_to do |format|
      if @movie.update_attributes(params[:movie])
        format.html { redirect_to(@movie, :notice => 'Movie was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @movie.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /movies/1
  # DELETE /movies/1.xml
  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy

    respond_to do |format|
      format.html { redirect_to(movies_url) }
      format.xml  { head :ok }
    end
  end
  
  def getData(title)
    @something = Choice.new()
    if @something == nil
      return false
    end
    @something.findTopFive(title)
    if @something.topFive == nil
      return false
    end
    @topFive = @something.topFive
    return true
  end
    
end
