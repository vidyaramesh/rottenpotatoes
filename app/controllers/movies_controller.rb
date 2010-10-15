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
      if params[:movie]
        format.html { redirect_to(create_movie_path()) }
        format.xml
      else
        format.html { redirect_to(movies_url) }
        format.xml
      end
    end
  end

  def results
    self.getData(params[:title])
    respond_to do |format|
      format.html #search.html.erb
      format.xml
    end
  end
  
  # GET /movies/new
  # GET /movies/new.xml
  def new
    @movie = Movie.new

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
    title = "Transformer"
    url = "http://api.themoviedb.org/2.1/Movie.search/en/xml/" + "427e9c369e1ace82a41bcc7e68bfc5cc" + "/" + title
    doc = Hpricot(open(url))
    eles = doc.search("movie")
    @topFive = Array.new()
    (0..4).each do |i|
      movie = Movie.new
      movie.title = eles[i].search("name").inner_html
      movie.description = eles[i].search("overview").inner_html
      movie.score = eles[i].search("score").inner_html
      movie.rating = eles[i].search("rating").inner_html
      movie.release_date = Time.parse(eles[i].search("released").inner_html)
      @topFive << movie
    end
    @topFive.sort! { |a,b| a.score <=> b.score }
  end
    
end
