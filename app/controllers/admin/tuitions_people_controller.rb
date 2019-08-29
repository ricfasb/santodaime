class Admin::TuitionsPeopleController < Admin::AdminController

    before_action :set_tuition_person, only: [:update]
    before_action :authenticate_user! 

    def update        
        if @tuition_person.update(tuition_person_params)
            @username = User.find( current_user.id )
            render :json => { :status => :true, :username => @username }
        else
            format.json { render json: @tuition_person.errors, status: :unprocessable_entity }
            format.js   { render action: 'message'}
        end        
    end

    private
        # Use callbacks to share common setup or constraints between actions.
        def set_tuition_person
            @tuition_person = TuitionPerson.find(params[:id])
            @tuition_person.cancel_date = DateTime.now
            @tuition_person.person_cancel = current_user.id
        end
        
        def tuition_person_params
            params.require(:tuition_person).permit(:id)
        end

end