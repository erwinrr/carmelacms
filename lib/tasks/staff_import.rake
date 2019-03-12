namespace :sangera do 
  desc "this task imports staff scraped from sangera automotive website"

  task :staff_import => [:environment] do 
    mb_dealer = Group.find(4)
    puts "found dealership: " + mb_dealer.name
    puts "*" * 20

    employees = [ [ { name: 'Damon Culbertson',
          title: 'President/GM',
          email: 'dulberston@sangera.com' },
        { name: 'Bill Smith',
          title: 'Service & Parts Director',
          email: 'bsmith@sangera.com' },
        { name: 'Bobby Guerrero',
          title: 'Sales Manager',
          email: 'rguerrero@sangera.com' },
        { name: 'Joel Villagomez',
          title: 'Sales Manager',
          email: 'jvillagomez@sangera.com' },
        { name: 'Luciano Rubalcava',
          title: 'Parts Manager',
          email: 'lrubalcava@sangera.com' },
        { name: 'Mike Davidson',
          title: 'Preowned Sales Manager',
          email: 'mdavidson@sangera.com' },
        { name: 'PJ Nichols',
          title: 'Finance Director',
          email: 'pjnichols@sangera.com' },
        { name: 'Suki Sanghera',
          title: 'Sales Manager',
          email: 'ssangera@sangera.com' },
        { name: 'Tiffany Caldwell',
          title: 'Human Resources',
          email: 'hr@sangera.com' } ],
      [ { name: 'Paula Arellano',
          title: 'Sales Consultant',
          email: 'parellano@sangera.com' },
        { name: 'Sam Awa',
          title: 'Sales Consultant',
          email: 'sawa@sangera.com' },
        { name: 'Harry Bhullar',
          title: 'Commercial Vans',
          email: 'hbhullar@sangera.com' },
        { name: 'Campbell Cameron',
          title: 'Sales Consultant',
          email: 'ccameron@sangera.com' },
        { name: 'Javier Cruz',
          title: 'Sales Consultant',
          email: 'jcruz@sangera.com' },
        { name: 'Mike Garibay',
          title: 'Retention Manager',
          email: 'mgaribay@sangera.com' },
        { name: 'Rafael Hurtado',
          title: 'Sales Consultant',
          email: 'rhurtado@sangera.com' },
        { name: 'Surinder Mangat',
          title: 'Internet Sales Manager',
          email: 'smangat@sangera.com' },
        { name: 'Mohamed Msouti',
          title: 'Sales Consultant',
          email: 'mmsouti@sangera.com' },
        { name: 'Jennifer Peoples',
          title: 'Sales Consultant',
          email: 'jpeoples@sangera.com' },
        { name: 'Phillip Ramirez',
          title: 'Sales Consultant',
          email: 'pramirez@sangera.com' },
        { name: 'Nick Sakowski',
          title: 'Retention Manager',
          email: 'nsakowski@sangera.com' },
        { name: 'Lupe Valdovinos',
          title: 'Sales Consultant',
          email: 'lvaldovinos@sangera.com' },
        { name: 'Jim Whelden',
          title: 'Product Concierge',
          email: 'jwhelden@sangera.com' } ],
      [ { name: 'Bryan Brown',
          title: 'Asst Service Manager',
          email: 'bbrown@sangera.com' },
        { name: 'John Hoffman',
          title: 'Service Consultant',
          email: 'jhoffman@sangera.com' },
        { name: 'Michelle Ortiz',
          title: 'Service Coordinator',
          email: 'mortiz@sangera.com' },
        { name: 'Alfred Ramirez',
          title: 'Service Consultant',
          email: 'aramirez@sangera.com' },
        { name: 'Maria Serrato',
          title: 'Service Consultant',
          email: 'mserrato@sangera.com' },
        { name: 'Lauren Taylor',
          title: 'Transportation Manager',
          email: 'laurentaylor@sangera.com' } ],
      [ { name: 'Carlos Orrego',
          title: 'Parts Consultant',
          email: 'corrego@sangera.com' },
        { name: 'Vincent Hernandez',
          title: 'Parts Consultant / Wholesale Specialist',
          email: 'vhernandez@sangera.com' },
        { name: 'Joshua Schroeter',
          title: 'Parts Consultant',
          email: 'jschroeter@sangera.com' } ],
      [ { name: 'Craig Tomkins',
          title: 'Finance Manager',
          email: 'ctomkins@sangera.com' },
        { name: 'Tiffany Williams',
          title: 'Finance Manager',
          email: 'twilliams@sangera.com' } ] ]   
          
    management_staff = employees[0]
    sales_staff = employees[1]
    service_staff = employees[2]
    parts_staff = employees[3]
    finance_staff = employees[4] 
    
    management_dep = mb_dealer.departments.where("name ilike '%management%'")
    sales_dep = mb_dealer.departments.where("name ilike '%sales%'")
    service_dep = mb_dealer.departments.where("name ilike '%service%'")
    parts_dep = mb_dealer.departments.where("name ilike '%parts%'")
    finance_dep = mb_dealer.departments.where("name ilike '%finance%'")

    def add_users(staff, department, role)
      staff.each do |employee|
        mb_dealer = Group.find(4)
        new_id = User.last.id + 1
        new_user = mb_dealer.users.create!(email: employee[:email], password: "$ecret#{new_id}", first_name: employee[:name].split(' ').first, last_name: employee[:name].split(' ').last, title: employee[:title])
        new_user.departments << department
        new_user.add_role(role)
        new_user.save
        puts "created user: "+ employee[:name]
        puts "*" * 20
      end
    end

    add_users(management_staff, management_dep, :manager)
    add_users(sales_staff, sales_dep, :sales_staff)
    add_users(service_staff, service_dep, :staff)
    add_users(parts_staff, parts_dep, :staff)
    add_users(finance_staff, finance_dep, :staff)
  end
end