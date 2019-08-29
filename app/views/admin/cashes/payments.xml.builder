xml.instruct! :xml, :version => '1.0', :encoding => 'utf-8'
xml.cashes do
    @cashes.each do |cash|
        xml.cash do
            xml.person cash.person
            xml.created_at format_date_hour cash.created_at.to_s            
        end
    end
end