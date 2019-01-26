# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

    #Categoria
    Category.create(id: 1, description: 'Fardado')
    Category.create(id: 2, description: 'Visitante')
    Category.create(id: 3, description: 'On-line')

    #Estado civil
    MaritalState.create(description: 'Solteiro')
    MaritalState.create(description: 'Casado')
    MaritalState.create(description: 'Viúvo')
    MaritalState.create(description: 'Separado judicialmente')
    MaritalState.create(description: 'Divorciado')

    #Grau de escolaridade
    DegreeEducation.create(description: 'Fundamental - Incompleto')
    DegreeEducation.create(description: 'Fundamental - Completo')
    DegreeEducation.create(description: 'Médio - Incompleto')
    DegreeEducation.create(description: 'Médio - Completo')
    DegreeEducation.create(description: 'Superior - Incompleto')
    DegreeEducation.create(description: 'Superior - Completo')
    DegreeEducation.create(description: 'Pós-graduação (Lato senso) - Incompleto')
    DegreeEducation.create(description: 'Pós-graduação (Lato senso) - Completo')
    DegreeEducation.create(description: 'Pós-graduação (Scricto sensu, nível mestrado) - Incompleto')
    DegreeEducation.create(description: 'Pós-graduação (Scricto sensu, nível mestrado) - Completo')
    DegreeEducation.create(description: 'Pós-graduação (Scricto sensu, nível doutor) - Incompleto')
    DegreeEducation.create(description: 'Pós-graduação (Scricto sensu, nível doutor) - Completo')

    InvoiceType.create(id: 1, description: 'Multa')
    #InvoiceType.create(id: 2, description: 'Visitante')
    #InvoiceType.create(id: 3, description: 'On-line')
    # 100.times do
    #     Category.create(description: Faker::Lorem.sentence)
    # end

    # 20.times do            
    #     @address = Address.create(zip_code: Faker::Address.zip_code, street: Faker::Address.street_name,
    #         number: Faker::Address.building_number,
    #         complement: '',
    #         reference: '',
    #         neighbourhood: '',          
    #         addressable_type: 'Company')
    #     Company.create(name: Faker::Company.name, telephone: '41999995555', address: @address)
    # end
  
