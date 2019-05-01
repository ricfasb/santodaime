namespace :tests do
  desc "Gerar Pessoas Rake"
  task fake_people: :environment do
    20.times do            
      @address = Address.create(zip_code: Faker::Address.zip_code, street: Faker::Address.street_name,
          number: Faker::Address.building_number,
          complement: '',
          reference: '',
          neighbourhood: '',          
          addressable_type: 'Company')
      Company.create(name: Faker::Company.name, telephone: '41999995555', address: @address)
    end    
  end
