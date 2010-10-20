Given /^the user is looking to add a movie by searching for its title$/ do
  visit search_path() # express the regexp above with the code you wish you had
end

When /^the user arrives on the search page$/ do
  
end

Then /^the user should see a place to enter the title of the movie they want to search$/ do
  fill_in "title" # express the regexp above with the code you wish you had
end

Given /^the user is on the search page with "[a-zA-Z0-9]+" as the title of the movie entered$/ do |title|
  visit search_path()
  fill_in "title", :with => title # express the regexp above with the code you wish you had
end

When /^the user clicks button$/ do
  click_button "Results" # express the regexp above with the code you wish you had
end

Then /^the user should see a listing of at most (\d+) possible results$/ do |arg1|
  response.should contain "The Matrix" # express the regexp above with the code you wish you had
end

Given /^the user is looking at the not empty search results for a query$/ do
  visit search_path()
  fill_in "title", :with=>"The Matrix"
  click_button "Results"
  response.should contain "The Matrix" # express the regexp above with the code you wish you had
end

When /^the user selects one of the results and clicks submit$/ do
  choose "movieChoice"
  click_button "Choose" # express the regexp above with the code you wish you had
end

Then /^the user should see a page with the information for that movie filled out$/ do
  response.should contain("The Matrix")# express the regexp above with the code you wish you had
end

Given /^the user is looking for a query and there are no results$/ do
  visit search_path()
  fill_in "title", :with=>"lksjdoquwer"
  click_button "Results" # express the regexp above with the code you wish you had
end

Given /^the user is on the search page with "[a-zA-Z0-9]+" as the title of the movie entered$/ do |arg1|
  visit search_path()
  fill_in "title", :with => arg1 # express the regexp above with the code you wish you had
  click_button "Results"
end

When /^the user clicks search$/ do
end

Then /^the user should see a message saying "[a-zA-Z0-9]*"$/ do |arg1|
  response.should contain(arg1) # express the regexp above with the code you wish you had
end

Given /^the user is on the search page with "([^"]*)" as the title of the movie entered$/ do |arg1|
  visit search_path()
  fill_in "title", :with => arg1
  click_button "Results"
end

When /^the user selects one of the results$/ do
  choose "movieChoice" # express the regexp above with the code you wish you had
end

Then /^the user should see a message saying "([^"]*)"$/ do |arg1|
  response.should contain(arg1) # express the regexp above with the code you wish you had
end

