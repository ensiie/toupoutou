Feature: Calendar
  @wip

  Scenario: See the calendar
    Given I am an authenticated user
    When I go to the dashboard page
    Then I see the anniversaries of my friends that are in the next "3" weeks
    
