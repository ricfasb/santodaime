xml.instruct! :xml, :version => '1.0', :encoding => 'utf-8'
xml.cashes do
    @cashes.each do |cash|
        xml.cash do
            xml.charge_back_date format_date_hour cash.charge_back_date.to_s
            xml.name cash.person
            xml.category cash.category            
            xml.person_charge_back cash.person_charge_back
            xml.type cash.type            
            xml.amount cash.amount
        end
    end
end 