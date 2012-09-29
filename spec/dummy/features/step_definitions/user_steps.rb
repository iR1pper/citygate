### UTILITY METHODS ###

def current_path
  URI.parse(current_url).path
end

def create_visitor
  @visitor ||= { :first_name => "User", :email => "example@example.com",
    :password => "bigpasswordisbig", :password_confirmation => "bigpasswordisbig" }
end

def find_user
  @user ||= Citygate::User.first conditions: {:email => @visitor[:email]}
end

def create_unconfirmed_user
  create_visitor
  delete_user
  sign_up
end

def create_or_get_user
  @user ||= lambda do
     create_visitor
     delete_user
     Factory.create(:user, email: @visitor[:email])
  end.call
  @user.confirmation_sent_at = Time.now
  @user.save
  return @user
end

def delete_user
  @user ||= Citygate::User.first conditions: {:email => @visitor[:email]}
  @user.destroy unless @user.nil?
end

def sign_up
  delete_user
  visit '/users/sign_up'
  fill_in "user_email", :with => @visitor[:email]
  fill_in "user_password", :with => @visitor[:password]
  fill_in "user_password_confirmation", :with => @visitor[:password_confirmation]
  click_button "Sign up"
  find_user
end

def sign_in
  visit '/users/sign_in'
  fill_in "Email", :with => @visitor[:email]
  fill_in "Password", :with => @visitor[:password]
  click_button "Sign in"
end

### GIVEN ###
Given /^I am not logged in$/ do
  page.should_not have_link('Log out')
end

Given /^I am logged in$/ do
  create_or_get_user
  sign_in
end

Given /^I am a member$/ do
  create_or_get_user
  @user.role_id = 1
  @user.save
end

Given /^I am an admin$/ do
  create_or_get_user
  @user.role_id = 2
  @user.save
end

Given /^I exist as a user$/ do
  create_or_get_user
end

Given /^I do not exist as a user$/ do
  create_visitor
  delete_user
end

Given /^I exist as an unconfirmed user$/ do
  create_unconfirmed_user
end

Given /^I am on (.*)$/ do |path|
  visit path_to(path)
end

Given /^I do not have an? (.*)$/ do |attribute|
  create_or_get_user
  @user[attribute] = nil
end

### WHEN ###
When /^I sign in with valid credentials$/ do
  create_visitor
  sign_in
end

When /^I sign out$/ do
  click_link 'Log out'
end

When /^I sign up with valid user data$/ do
  create_visitor
  sign_up
end

When /^I sign up with an invalid email$/ do
  create_visitor
  @visitor = @visitor.merge(:email => "notanemail")
  sign_up
end

When /^I sign up without a password confirmation$/ do
  create_visitor
  @visitor = @visitor.merge(:password_confirmation => "")
  sign_up
end

When /^I sign up without a password$/ do
  create_visitor
  @visitor = @visitor.merge(:password => "")
  sign_up
end

When /^I sign up with a mismatched password confirmation$/ do
  create_visitor
  @visitor = @visitor.merge(:password_confirmation => "please123")
  sign_up
end

When /^I return to the site$/ do
  visit '/'
end

When /^I sign in with a wrong email$/ do
  @visitor = @visitor.merge(:email => "wrong@example.com")
  sign_in
end

When /^I sign in with a wrong password$/ do
  @visitor = @visitor.merge(:password => "wrongpass")
  sign_in
end

When /^I edit my account details$/ do
  click_link "Edit account"
  fill_in "user_current_password", :with => @visitor[:password]
  click_button "Update"
end

When /^I look at the list of users$/ do
  visit '/admin/users'
end

When /^I click (.*)$/ do |link|
  click_link link
end

When /^I submit the form$/ do
  page.evaluate_script("document.forms[0].submit()")
end

When /^I fill in '(.*)' with '(.*)'$/ do |field, value|
  fill_in field, :with => value
end

When /^I go back in history$/ do
  sleep 2
  page.execute_script("history.back()")
end

### THEN ###
Then /^I should be signed in$/ do
  page.should have_content "Log out"
  page.should_not have_content "Sign up"
  page.should_not have_content "Log in"
end

Then /^I should be signed in with (.*)$/ do |provider|
  page.should have_content "Successfully authorized from #{provider} account"
end

Then /^I should be signed out$/ do
  page.should have_content "Sign up"
  page.should_not have_content "Log out"
end

Then /^I see an unconfirmed account message$/ do
  page.should have_content "You have to confirm your account before continuing."
end

Then /^I see a successful sign in message$/ do
  page.should have_content "Signed in successfully."
end

Then /^I should see a successful sign up message$/ do
  page.should have_content "A message with a confirmation link has been sent to your email address."
end

Then /^I should see an invalid email message$/ do
  page.should have_content "Email is invalid"
end

Then /^I should see a missing password message$/ do
  page.should have_content "Password can't be blank"
end

Then /^I should see a missing password confirmation message$/ do
  page.should have_content "Password doesn't match confirmation"
end

Then /^I should see a mismatched password message$/ do
  page.should have_content "Password doesn't match confirmation"
end

Then /^I should see a signed out message$/ do
  page.should have_content "Signed out successfully."
end

Then /^I see an invalid login message$/ do
  page.should have_content "Invalid email or password."
end

Then /^I should see an account edited message$/ do
  page.should have_content "You updated your account successfully."
end

Then /^I should see a user edit success message$/ do
  page.should have_content "User updated successfully"
end

Then /^I should (not )?see my (.*)$/ do |nonexistent, attribute|
  create_or_get_user
  if nonexistent
    page.should_not have_content @user[attribute]
  else
    page.should have_content @user[attribute]
  end
end

Then /^I should see the (.*) of user number (.*)$/ do |attribute,id|
  page.should have_content Citygate::User.find(id)[attribute]
end

Then /^the (.*) of user number (\d+) should now be '(.*)'$/ do |attribute, id, value|
  Citygate::User.find(id)[attribute].should == value
end

Then /^the element with (class |id )(.*) should (not )?exist$/ do |type, name, nonexistent|
  selector = %Q{#{(type.strip == 'class') ? '.' : '#'}#{name}}
  if nonexistent
    page.should_not have_css selector
  else
    page.should have_css selector
  end
end

Then /^I can see (.*)$/ do |text|
  has_link?(text).should be_true
end

Then /^I should be redirected to (.*)$/ do |path|
  current_path.should == path_to(path)
end
