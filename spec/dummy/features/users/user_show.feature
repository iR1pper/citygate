Feature: Show Users
  As a visitor to the website
  I want to see registered users listed on the homepage
  so I can know if the site has users

    Scenario: Viewing users
      Given I exist as a user
      And I am logged in
      When I look at the list of users
      Then I should see my name
      And I should see my email

    Scenario: Viewing users without name
      Given I exist as a user
      And I am logged in
      And I do not have a name
      When I look at the list of users
      Then the element with class name should not exist
      And I should see my email
