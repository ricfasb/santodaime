xml.instruct! :xml, :version => '1.0', :encoding => 'utf-8'
xml.people do
    @people.each do |person|
        xml.person do
            xml.name person.name
            xml.category person.category.description
        end
    end
end