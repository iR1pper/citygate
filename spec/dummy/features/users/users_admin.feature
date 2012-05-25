Feature: Admin Users
  As an administrator on the website
  I want to see registered users listed on the backend so I can manage them

    Scenario: Going to the administration page
      Given I exist as a user
      And I am logged in
      And I am an admin
      And I am on the home page
      Then I can see Admin

    Scenario: Viewing users
      Given I exist as a user
      And I am logged in
      And I am an admin
      When I look at the list of users
      Then I should see my name
      And I should see my email

    Scenario: Viewing users without name
      Given I exist as a user
      And I am logged in
      And I am an admin
      And I do not have a name
      When I look at the list of users
      Then the element with class name should not exist
      And I should see my email

    Scenario: Viewing users without privileges
      Given I exist as a user
      And I am not logged in
      When I look at the list of users
      Then I should be redirected to the home page

    @javascript
    Scenario: Click the show user and then click the browser back button should work as expected
      Given I exist as a user
      And I am logged in
      And I am an admin
      When I look at the list of users
      And I click Show
      And I go back in history
      Then I should be redirected to the users admin page
      And I should see the name of user number 1
