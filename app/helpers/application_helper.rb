module ApplicationHelper

    def active_class(link_path)
        current_page?(link_path) ? "active" : ""
    end

    def format_dt(date)
        Date.parse(date).strftime("%d/%m/%Y")
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
        puts "Logged #{current_user}"
        User.find( current_user.id )
    end

    def user_name( id ) 
        User.find( id ).email
    end

    def permission number
        @count = ProfilePermission.where(profile_id: profile_logged.profile.id, permission_id: number ).count
        if @count > 0
            true
        else
            false
        end
    end

    def link_to_add_fields_2(name, f, association, class_name)
        new_object = f.object.send(association).klass.new
        id = new_object.object_id
        fields = f.fields_for(association, new_object, category_tuition: id) do |builder|
            render(association.to_s.singularize, f: builder)
        end

        link_to(name, '#', class: "#{class_name} add_fields nested-add-btn", data: {id: id, fields: fields.gsub("\n", "")})
    end

    def link_to_add_fields(name, f, association, class_name)
        new_object = f.object.send(association).klass.new        
        id = new_object.object_id        
        fields = f.fields_for(association, new_object, child_index: id) do |builder|
            render(association.to_s.singularize, f: builder)
        end

        link_to(raw('<i class="material-icons">add</i>'+name), '#', class: "#{class_name} btn btn-success", data: {id: id, fields: fields.gsub("\n", "")})
    end    
    
end
