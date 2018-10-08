puts 'SEED FILE'
puts '*' * 200
organization = Organization.create!(name: 'Kitfox Automotive')
puts 'created organization'
dealership1 = organization.groups.create!(name: 'Cars of Athens Dealership')
puts 'created department1'
admin = dealership1.users.create!(email: 'admin@gmail.com', password: 'hola32', first_name: 'Erwin', last_name: 'Juarez')
admin.add_role(:admin)
puts 'created admin user'
puts '*' * 200