Factory.define :user do |f|
  f.name 'Test User'
  f.email 'example@example.com'
  f.password 'please'
  f.password_confirmation 'please'
  # required if the Devise Confirmable module is used
  f.confirmed_at Time.now
end