Given /^the user is looking to add a movie by searching for its title$/ do
  visit search_path() # express the regexp above with the code you wish you had
end

When /^the user arrives on the search page$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^the user should see a place to enter the title of the movie they want to search$/ do
  response.should contain textfield # express the regexp above with the code you wish you had
end

Given /^the user is on the search page with a title of the movie entered$/ do
  visit search_path()
  fill_in "Title", :with=>"The Matrix" # express the regexp above with the code you wish you had
end

When /^the user clicks search$/ do
  click_button "Search" # express the regexp above with the code you wish you had
end

Then /^the user should see a listing of at most (\d+) possible results$/ do |arg1|
  response.should contain "The Matrix" # express the regexp above with the code you wish you had
end

Given /^the user is looking at the not empty search results for a query$/ do
  visit seach_path()
  fill_in "Title", :with=>"The Matrix"
  click_button "Search"
  response.should contain "The Matrix" # express the regexp above with the code you wish you had
end

When /^the user selects one of the results and clicks submit$/ do
  choose "The Matrix"
  click_botton "Submit" # express the regexp above with the code you wish you had
end

Then /^the user should see a page with the information for that movie filled out$/ do
  pending # express the regexp above with the code you wish you had
end

Given /^the user is looking for a query and there are no results$/ do
  visit search_path()
  fill_in "Title", :with=>"Glaskdjf"
  click_button "Search" # express the regexp above with the code you wish you had
end

Then /^the user should see a message saying "([^"]*)" and should stay on search page$/ do |arg1|
  response.should contain(arg1) # express the regexp above with the code you wish you had
end
