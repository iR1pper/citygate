Factory.define :user, :class => "Citygate::User" do |f|
  f.name                  'Test User'
  f.email                 'example@example.com'
  f.password              'please'
  f.password_confirmation 'please'
  
  # required if the Devise Confirmable module is used
  f.confirmed_at           Time.now
end

Factory.define :facebook_auth, :class => "Citygate::Authorization" do |f|
  f.provider   'Facebook'
  f.uid        '28'
  f.name       'Testy McTest'
  f.link       'http://www.facebook.com/luis.zamith'
  f.image_url  'http://graph.facebook.com/754864768/picture?type=square'
end

Factory.define :google_auth, :class => "Citygate::Authorization" do |f|
  f.provider   'Google'
  f.uid        '28'
  f.name       'Testy McTest'
end

Factory.define :facebook_user, :parent => :user do |user|
  user.name nil
  user.after_create {|fb_user| Factory.create(:facebook_auth, :user => fb_user)}
end

Factory.define :google_user, :parent => :user do |user|
  user.name nil
  user.after_create {|g_user| Factory.create(:google_auth, :user => g_user)}
end