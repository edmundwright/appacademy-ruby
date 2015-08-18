# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# run rake db:reset before this
# Cat.destroy_all

Cat.create!(:color => "orange", :name => "Hairball", :sex => "F",  :birth_date => "19990105", :description => "Stray cat.")
Cat.create!(:color => "black", :sex => "F", :name => "Catto", :birth_date => "19990101")
Cat.create!(:color => "orange", :sex => "M", :name => "Sennacy", :description => "AppAcademy famous cat", :birth_date => "2")
