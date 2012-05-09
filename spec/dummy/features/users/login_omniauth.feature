@omniauth
Feature: Login
  In order to login easily
  As a user of other websites
  I want to be able to login with those credentials

  @facebook
  Scenario: Login with Facebook
    Given I am on the login page
    Then I can see Sign in with Facebook
    When I click Sign in with Facebook
    Then I should be signed in with Facebook

  @google
  Scenario: Login with Google
    Given I am on the login page
    Then I can see Sign in with Google
    When I click Sign in with Google
    Then I should be signed in with Google
