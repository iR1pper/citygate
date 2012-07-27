# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts 'SETTING UP ROLES...'
roles = [ 
  {:name => "Member"},
  {:name => "Admin"}
]

roles.each do |attributes| 
  Citygate::Role.find_or_initialize_by_name(attributes[:name]).save!
end

puts 'Creating permission for citygate...'
permissions = [
  # Guest
  {:action => "index", :subject_class => "home", :role_id => nil },
  # Member
  {:action => "read", :subject_class => "Citygate::User", :role_id => 1 },
  # Admin
  {:action => "manage", :subject_class => "all", :role_id => 2 }
]

permissions.each do |attributes| 
  Citygate::Permission.create attributes
end unless Citygate::Permission.find_by_action_and_subject_class_and_role_id("index","home",nil)
