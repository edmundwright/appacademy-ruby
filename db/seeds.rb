# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# run rake db:reset before this
# Cat.destroy_all

Cat.create!(:color => "orange", :name => "Hairball", :sex => "F",
  :birth_date => "19990105", :description => "Stray cat.")
Cat.create!(:color => "black", :sex => "F", :name => "Catto",
  :birth_date => "19990101")
Cat.create!(:color => "orange", :sex => "M", :name => "Sennacy",
  :description => "AppAcademy famous cat", :birth_date => "19850905")

CatRentalRequest.create!(cat_id: 1, start_date: "19000101", end_date: "19050101")
CatRentalRequest.create!(cat_id: 1, start_date: "19030101", end_date: "19080101")
CatRentalRequest.create!(cat_id: 1, start_date: "19060101", end_date: "19120101")

CatRentalRequest.create!(cat_id: 1, start_date: "19500101", end_date: "19550101")

CatRentalRequest.create!(cat_id: 1, start_date: "19700101", end_date: "19750101")

CatRentalRequest.create!(cat_id: 2, start_date: "19000101", end_date: "19050101")
CatRentalRequest.create!(cat_id: 2, start_date: "19030101", end_date: "19080101")
CatRentalRequest.create!(cat_id: 2, start_date: "19060101", end_date: "19120101")

CatRentalRequest.create!(cat_id: 2, start_date: "19500101", end_date: "19550101")

CatRentalRequest.create!(cat_id: 2, start_date: "19700101", end_date: "19750101")

CatRentalRequest.create!(cat_id: 3, start_date: "19000101", end_date: "19050101")
CatRentalRequest.create!(cat_id: 3, start_date: "19030101", end_date: "19080101")
CatRentalRequest.create!(cat_id: 3, start_date: "19060101", end_date: "19120101")

CatRentalRequest.create!(cat_id: 3, start_date: "19500101", end_date: "19550101")

CatRentalRequest.create!(cat_id: 3, start_date: "19700101", end_date: "19750101")
