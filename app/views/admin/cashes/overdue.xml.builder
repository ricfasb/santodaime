xml.instruct! :xml, :version => '1.0', :encoding => 'utf-8'
xml.cashes do
    @cashes.each do |cash|
        xml.cash do
            xml.created_at format_date_hour cash.created_at.to_s
            xml.category cash.category
            xml.name cash.person            
            xml.type cash.type
            xml.due_date cash.due_date
            xml.amount cash.amount
        end
    end
end 