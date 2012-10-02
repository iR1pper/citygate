require 'spec_helper'

describe Citygate::User do

  before(:each) do
    @attr = {
      :first_name            => "User",
      :email                 => "user@example.com",
      :password              => "bigpasswordisbig",
      :password_confirmation => "bigpasswordisbig"
    }
  end

  it "should return the full name if it has one" do
    @user = Citygate::User.new(@attr)
    @user.to_s.should == "User"
  end

  it "should return the full name if it has one" do
    @attr.delete :first_name
    @user = Citygate::User.new(@attr)
    @user.to_s.should == "user@example.com"
  end

  it "should render the correct json hash" do
    fb_user = Factory.create(:facebook_user)
    fb_user.as_json.should == {
      :name        => "User",
      :email       => "example@example.com",
      :link        => "http://www.facebook.com/luis.zamith",
      :image       => "http://graph.facebook.com/754864768/picture?type=square"
    }
  end

  it "should create a new instance given a valid attribute" do
    Citygate::User.create!(@attr)
  end

  it "should require an email address" do
    no_email_user = Citygate::User.new(@attr.merge(:email => ""))
    no_email_user.should_not be_valid
  end

  it "should accept valid email addresses" do
    addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      valid_email_user = Citygate::User.new(@attr.merge(:email => address))
      valid_email_user.should be_valid
    end
  end

  it "should reject invalid email addresses" do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
    addresses.each do |address|
      invalid_email_user = Citygate::User.new(@attr.merge(:email => address))
      invalid_email_user.should_not be_valid
    end
  end

  it "should reject duplicate email addresses" do
    Citygate::User.create!(@attr)
    user_with_duplicate_email = Citygate::User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end

  it "should reject email addresses identical up to case" do
    upcased_email = @attr[:email].upcase
    Citygate::User.create!(@attr.merge(:email => upcased_email))
    user_with_duplicate_email = Citygate::User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end

  describe "passwords" do
    before(:each) do
      @user = Citygate::User.new(@attr)
    end

    it "should have a password attribute" do
      @user.should respond_to(:password)
    end

    it "should have a password confirmation attribute" do
      @user.should respond_to(:password_confirmation)
    end
  end

  describe "password validations" do
    it "should require a password" do
      Citygate::User.new(@attr.merge(:password => "", :password_confirmation => "")).
        should_not be_valid
    end

    it "should require a matching password confirmation" do
      Citygate::User.new(@attr.merge(:password_confirmation => "invalid")).
        should_not be_valid
    end

    it "should reject short passwords" do
      short = "a" * 5
      hash = @attr.merge(:password => short, :password_confirmation => short)
      Citygate::User.new(hash).should_not be_valid
    end
  end

  describe "password encryption" do
    subject { Citygate::User.create!(@attr) }

    it { should respond_to(:encrypted_password) }
    its(:encrypted_password) { should_not be_blank }
  end

  context "is_a methods" do
    it "has an is_x? method for each role" do
      user = create_user
      #ability = create_ability_with_roles_for_user user
      role_names = [
        mock_model(Citygate::Role, name: "member"),
        mock_model(Citygate::Role, name: "admin"),
        mock_model(Citygate::Role, name: "crazy_man")
      ]
      Citygate::Role.stub(:select).with(:name).and_return(role_names)

      user.stub(:role).and_return mock_model(Citygate::Role, name: "member")
      user.should respond_to :is_member?

      user.stub(:role).and_return mock_model(Citygate::Role, name: "admin")
      user.should respond_to :is_admin?

      user.stub(:role).and_return mock_model(Citygate::Role, name: "crazy_man")
      user.should respond_to :is_crazy_man?
    end

    it "gives an answer to is_admin?" do
      user = create_user
      Citygate::User.remove_possible_method :is_admin?

      role_names = [ mock_model(Citygate::Role, name: "admin") ]
      Citygate::Role.stub(:select).with(:name).and_return(role_names)

      user.stub(:role).and_return mock_model(Citygate::Role, name: "admin")
      user.is_admin?.should eq true
    end
  end

  def create_user
    Citygate::User.new(@attr)
  end

  def create_ability_with_roles_for_user(user)
    roles = [
      { name: "member" }, 
      { name: "admin" },
      { name: "crazy_man" }
    ]
    Citygate::Engine.stub(:roles).and_return(roles)
    Ability.new user
  end
end
