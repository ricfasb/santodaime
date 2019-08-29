xml.instruct! :xml, :version => '1.0', :encoding => 'utf-8'
xml.cashes do
    @cashes.each do |cash|
        xml.cash do
            xml.name cash.person.name
            xml.created_at format_date_hour cash.created_at.to_s
            xml.category cash.person.category.description
        end
    end
end