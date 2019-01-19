puts 'SEED FILE'
puts '*' * 200
organization = Organization.create!(name: 'Kitfox Automotive')
puts 'created organization'
dealership1 = organization.groups.create!(name: 'Athens Dealership')
puts 'created department1'
Role.create!(name:"admin")
Role.create!(name:"owner")
Role.create!(name:"manager")
Role.create!(name:"staff")
Role.create!(name:"customer")
puts 'created 5 roles!'
admin = dealership1.users.create!(email: 'admin@gmail.com', password: 'hola32', first_name: 'Erwin', last_name: 'Juarez')
admin.add_role(:admin)
puts 'created admin user'
puts '*' * 200