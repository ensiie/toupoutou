Feature:
  @wip
  Scenario:
    Given I am an authenticated user
    When I am on the dashboard page
    And I click on the "Add Item" button
		And I fill in "Name" with "NewItem"
		Then I can see my item on the page


