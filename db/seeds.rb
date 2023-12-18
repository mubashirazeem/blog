# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


# Category.create(name: "Fiction")
# Category.create(name: "Nature")
# Category.create(name: "Biography")
# Category.create(name: "Poetry")
# Category.create(name: "Political")
# Category.create(name: "Funny")
# AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?



Role.create(name: "editior")
