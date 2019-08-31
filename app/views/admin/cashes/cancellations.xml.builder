xml.instruct! :xml, :version => '1.0', :encoding => 'utf-8'
xml.cashes do
    @cashes.each do |cash|
        xml.cash do
            xml.cancel_date format_date_hour cash.cancel_date.to_s
            xml.name cash.person
            xml.category cash.category            
            xml.person_cancel cash.person_cancel
            xml.type cash.type            
            xml.amount cash.amount
        end
    end
end 