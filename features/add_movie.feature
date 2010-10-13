Feature: User wants to add a movie
	Rather than inputting the movie’s title, rating, and release date, the users will enter only the title.  The application should search TMDb for the movie’s title and show the first five results to the user.  The user can either indicate which of the five is the one he/she intended, or the user can pick “None of these.”  If the user picks one of the five movies, the application should fill in the overview, scores, the rating, the release date, and the genre(s) and, after prompting the user, save the record to your database.  If the movie is not found, then they can enter another title to search for (flash a message saying “Movie not found” and keep them on the search page). 
	
	Scenario: find by title
	Given the user is looking to add a movie by searching for its title
	When the user arrives on the search page
	Then the user should see a place to enter the title of the movie they want to search
	
	Scenario: see search results
	Given the user is on the search page with a title of the movie entered
	When the user clicks search
	Then the user should see a listing of at most 5 possible results 
	
	Scenario: add from search results
	Given the user is looking at the not empty search results for a query
	When the user selects one of the results and clicks submit
	Then the user should see a page with the information for that movie filled out
	
	Scenario: no results
	Given the user is looking for a query and there are no results
	When the user clicks search
	Then the user should see a message saying "Movie is not found" and should stay on search page