module ApplicationHelper

    def active_class(link_path)
        current_page?(link_path) ? "active" : ""
    end

    def format_date(date)
        Date.parse(date).strftime("%d de %m %Y - %H:%M")
    end

    def code_completion(code)
        "0000"+code.to_s
    end
    
end
