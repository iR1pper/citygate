Factory.define :user, :class => "Citygate::User" do |f|
  f.first_name            'User'
  f.email                 'example@example.com'
  f.password              'bigpasswordisbig'
  f.password_confirmation 'bigpasswordisbig'
  
  # required if the Devise Confirmable module is used
  f.confirmed_at           Time.now
end

Factory.define :facebook_auth, :class => "Citygate::Authorization" do |f|
  f.provider   'Facebook'
  f.uid        '28'
  f.name       'User'
  f.link       'http://www.facebook.com/luis.zamith'
  f.image_url  'http://graph.facebook.com/754864768/picture?type=square'
end

Factory.define :google_auth, :class => "Citygate::Authorization" do |f|
  f.provider   'Google'
  f.uid        '28'
  f.name       'User'
end

Factory.define :facebook_user, :parent => :user do |user|
  user.first_name nil
  user.after_create {|fb_user| Factory.create(:facebook_auth, :user => fb_user)}
end

Factory.define :google_user, :parent => :user do |user|
  user.first_name nil
  user.after_create {|g_user| Factory.create(:google_auth, :user => g_user)}
end