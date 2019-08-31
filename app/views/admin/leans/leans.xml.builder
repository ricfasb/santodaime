xml.instruct! :xml, :version => '1.0', :encoding => 'utf-8'
xml.leans do
    @leans.each do |lean|
        xml.lean do
            xml.created_at format_date_hour lean.cancel_date.to_s
            xml.name cash.person
            xml.category cash.category            
            xml.person_cancel cash.person_cancel
            xml.type cash.type            
            xml.amount cash.amount
        end
    end
end 