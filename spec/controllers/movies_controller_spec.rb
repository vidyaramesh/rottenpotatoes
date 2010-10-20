require 'spec_helper'

describe MoviesController do

  def mock_movie(stubs={})
    @mock_movie ||= mock_model(Movie, stubs)
  end
  
  def mock_choice()
    @mock_choice ||= mock_model(Choice)
    @topFive = Array.new()
    (0..4).each do |i|
      movie = Movie.new
      movie.title = i.to_s() + "Title"
      movie.description = i.to_s() + "Desc"
      movie.score = i
      movie.rating = i
      movie.released_on = "Never"
      @topFive << movie
    end
	@mock_choice.stub(:findTopFive).with("not nil title").and_return(@topFive)
	return @mock_choice
  end
  
  describe "test TMBd API call" do
	it "returns a list of 5 movies" do
		@movies = mock_choice().findTopFive("not nil title")
		@movies.length.should == 5
	end
    
	it "adds one of the 5 returned movies to the DB" do
		@movies = mock_choice().findTopFive("not nil title")
		db = Array.new
		@mov = @movies[0]
		Movie.stub(:save) do
		  db << @mov
		end
		Movie.stub(:find) do
		  db[0]
		end
		@params = {:movieChoice => @mov.title, "title"+@mov.title => @mov.title, "description"+@mov.title => @mov.description, "score"+@mov.title => @mov.score, "rating"+@mov.title => @mov.rating, "released_on"+@mov.title => @mov.released_on}
		post "add", @params
		Movie.find.should == @movi
	end
	it "returns no values for an API result with no movies" do
		Hpricot.stub(:search).with("movie").and_return("")
		@choice = Choice.new()
		@choice.findTopFive("Anything").length.should == 0
	end
  end
  
  describe "GET index" do
    it "assigns all movies as @movies" do
      Movie.stub(:find).with(:all).and_return([mock_movie])
      get :index
      assigns[:movies].should == [mock_movie]
    end
  end

  describe "GET show" do
    it "assigns the requested movie as @movie" do
      Movie.stub(:find).with("37").and_return(mock_movie)
      get :show, :id => "37"
      assigns[:movie].should equal(mock_movie)
    end
  end

  describe "GET new" do
    it "assigns a new movie as @movie" do
      Movie.stub(:new).and_return(mock_movie)
      get :new
      assigns[:movie].should equal(mock_movie)
    end
  end

  describe "GET edit" do
    it "assigns the requested movie as @movie" do
      Movie.stub(:find).with("37").and_return(mock_movie)
      get :edit, :id => "37"
      assigns[:movie].should equal(mock_movie)
    end
  end

  describe "POST create" do
  
    describe "with valid params" do
      it "assigns a newly created movie as @movie" do
        Movie.stub(:new).with({'these' => 'params'}).and_return(mock_movie(:save => true))
        post :create, :movie => {:these => 'params'}
        assigns[:movie].should equal(mock_movie)
      end

      it "redirects to the created movie" do
        Movie.stub(:new).and_return(mock_movie(:save => true))
        post :create, :movie => {}
        response.should redirect_to(movie_url(mock_movie))
      end
    end
	
	describe "with valid params and stubbed DB" do
      it "assigns a newly created movie as @movie and checks persistance to mock DB" do
        Movie.stub(:new).with({'these' => 'params'}).and_return(mock_movie)
		db = Array.new
		mock_movie.stub(:save) do 
		  db << mock_movie
		end
		Movie.stub(:find) do
		  ind = db.index(mock_movie)
		  db[ind]
		end
        post :create, :movie => {:these => 'params'}
        assigns[:movie].should equal(mock_movie)
		Movie.find(mock_movie).should ==mock_movie
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved movie as @movie" do
        Movie.stub(:new).with({'these' => 'params'}).and_return(mock_movie(:save => false))
        post :create, :movie => {:these => 'params'}
        assigns[:movie].should equal(mock_movie)
      end

      it "re-renders the 'new' template" do
        Movie.stub(:new).and_return(mock_movie(:save => false))
        post :create, :movie => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested movie" do
        Movie.should_receive(:find).with("37").and_return(mock_movie)
        mock_movie.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :movie => {:these => 'params'}
      end

      it "assigns the requested movie as @movie" do
        Movie.stub(:find).and_return(mock_movie(:update_attributes => true))
        put :update, :id => "1"
        assigns[:movie].should equal(mock_movie)
      end

      it "redirects to the movie" do
        Movie.stub(:find).and_return(mock_movie(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(movie_url(mock_movie))
      end
    end

    describe "with invalid params" do
      it "updates the requested movie" do
        Movie.should_receive(:find).with("37").and_return(mock_movie)
        mock_movie.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :movie => {:these => 'params'}
      end

      it "assigns the movie as @movie" do
        Movie.stub(:find).and_return(mock_movie(:update_attributes => false))
        put :update, :id => "1"
        assigns[:movie].should equal(mock_movie)
      end

      it "re-renders the 'edit' template" do
        Movie.stub(:find).and_return(mock_movie(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested movie" do
      Movie.should_receive(:find).with("37").and_return(mock_movie)
      mock_movie.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the movies list" do
      Movie.stub(:find).and_return(mock_movie(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(movies_url)
    end
  end

end
