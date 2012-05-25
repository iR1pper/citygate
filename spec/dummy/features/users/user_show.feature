Feature: Show Users
  As an administrator on the website
  I want to see registered users listed on the backend so I can manage them

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
