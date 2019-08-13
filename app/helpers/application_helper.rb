module ApplicationHelper

    def active_class(link_path)
        current_page?(link_path) ? "active" : ""
    end

    def format_date(date)
        Date.parse(date).strftime("%d de %m %Y - %H:%M")
    end

    def format_date_hour(date)
        DateTime.parse(date).strftime("%d/%m/%Y - %H:%M:%S")
    end

    def format_date_hour_us(date)
        DateTime.parse(date).strftime("%Y-%m-%d %H:%M:%S.%L")
    end

    def format_date_hour_ini_us(date)
        DateTime.parse(date).strftime("%Y-%m-%d 00:00:01.123456")
    end

    def format_date_hour_fin_us(date)
        DateTime.parse(date).strftime("%Y-%m-%d 23:59:59.123456")
    end

    def format_date_only(date)
        Date.parse(date).strftime("%d/%m/%Y")
    end

    def format_date_dt(date)        
        date.strftime("%d/%m/%Y")
    end

    def format_date_dt_hr(date)        
        date.strftime("%d/%m/%Y %H:%M:%S")
    end

    def code_completion(code)
        "0000"+code.to_s
    end

    def profile_logged
        User.find( current_user.id )
    end

    def permission number
        @count = ProfilePermission.where(profile_id: profile_logged.profile.id, permission_id: number ).count
        if @count > 0
            true
        else
            false
        end
    end
    
end
