namespace :dados do

    desc "Gerar dados para a aplicacao"
    task insert: :environment do

        @people = Person.all
        
        @people.each do |person|
            person.destroy
        end

        20.times do |i|                     
            @person = Person.new
            @person.id = i+1
            @person.name = Faker::Name.name
            @person.email = Faker::Internet.email
            @person.date_born = Faker::Date.birthday(18, 65)
            @person.date_enroll = Faker::Date.backward(14)
            @person.category_id = 1 
            @person.build_address  
            @person.build_occupation
            @person.occupation.build_address
            @person.build_driver_license
            @person.build_deficiency_person                     
            begin                
                @person.save                               
            rescue StandardError => e  
                puts e
                puts e.message  
                puts e.backtrace.inspect  
            ensure 
                puts "Cadastrando #{@person.name}"
            end  
            
        end

        @tuitions = Tuition.all
        @tuitions.each do |tuition|
            tuition.destroy
        end

        5.times do |i|
            @tuition = Tuition.new
            @tuition.id = i+1
            @tuition.description = Faker::Job.title
            @tuition.day = 5
            @tuition.amount = Faker::Commerce.price
            @tuition.send_email = false
            @tuition.day_email = :null
            @tuition.email_id = :null
            begin
                @tuition.save
            rescue StandardError => e  
                puts e
                puts e.message  
                puts e.backtrace.inspect  
            ensure 
                puts "Cadastrando #{@tuition.description}"
            end  
        end

        @invoices = Invoice.all
        @invoices.each do |invoice| 
            invoice.destroy
        end

        15.times do |i|
            @invoice = Invoice.new
            @invoice.id = i+1
            @invoice.description = Faker::Job.title
            @invoice.person_id = 5
            @invoice.amount = Faker::Commerce.price
            @invoice.due_date = Faker::Date.backward(14)
            @invoice.invoice_type_id = 1
            begin
                @invoice.save
            rescue StandardError => e  
                puts e
                puts e.message  
                puts e.backtrace.inspect  
            ensure                 
                puts "Cadastrando #{@tuition.description}"
            end  
        end

        @tuitionsPerson = TuitionPerson.all
        @tuitionsPerson.each do |tuitionPerson| 
            tuitionPerson.destroy
        end

        12.times do |i|
            @tuitionsPerson = TuitionPerson.new
            @tuitionsPerson.id = i+1
            @tuitionsPerson.person_id = 5
            @tuitionsPerson.tuition_id = 1
            @tuitionsPerson.due_date = Faker::Date.backward(5)
            @tuitionsPerson.status_payment = :pending
            begin
                @tuitionsPerson.save
            rescue StandardError => e  
                puts e
                puts e.message  
                puts e.backtrace.inspect  
            ensure                 
                puts "Cadastrando #{@tuitionsPerson.status_payment}"
            end 
        end

        @emails = Email.all
        @emails.each do |email| 
            email.destroy
        end

        # 15.times do |i|
        #     @email = Email.new
        #     @email.id = i+1
        #     @email.company_id = 2
        #     @email.title = 'ChuckNorris'
        #     @email.subject = 'ChuckNorris present'
        #     @email.message = 'Faker ChuckNorris fact'
        #     begin
        #         @email.save
        #     rescue StandardError => e  
        #         puts e
        #         puts e.message  
        #         puts e.backtrace.inspect  
        #     ensure                 
        #         puts "Cadastrando #{@email.title}"
        #     end  
        # end
        
        @checkins = Checkin.all
        @checkins.each do |checkin| 
            checkin.destroy
        end

        15.times do |i|
            @checkin = Checkin.new
            @checkin.id = i+1
            @checkin.person_id = 2
            @checkin.company_id = 2
            begin
                @checkin.save
            rescue StandardError => e  
                puts e
                puts e.message  
                puts e.backtrace.inspect  
            ensure                 
                puts "Cadastrando #{@checkin.person.name}"
            end  
        end
        
    end
end