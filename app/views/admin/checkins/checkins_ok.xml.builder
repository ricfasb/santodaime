xml.instruct! :xml, :version => '1.0', :encoding => 'utf-8'
xml.checkins do
    @checkins.each do |checkin|
        xml.checkin do
            xml.name checkin.person.name
            xml.created_at format_date_hour checkin.created_at.to_s
            xml.category checkin.person.category.description
        end
    end
end