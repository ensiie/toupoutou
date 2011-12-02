Then /^I see the anniversaries of my friends that are in the next "([^"]*)" weeks$/ do |arg1|
  page.should have_content(@birthdays.count)
end
