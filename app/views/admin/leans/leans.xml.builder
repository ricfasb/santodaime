xml.instruct! :xml, :version => '1.0', :encoding => 'utf-8'
xml.leans do
    @leans.each do |lean|
        xml.lean do
            xml.created_at format_date_hour lean.created_at.to_s
            xml.name lean.person.name
            xml.category lean.person.category.description
            xml.product_name lean.product.name
            xml.expected_return format_date_only lean.expected_return.to_s                                    
            xml.quantity lean.quantity
        end
    end
end 