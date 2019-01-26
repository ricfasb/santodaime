class RegisterController < ApplicationController
  
  def new
    @person = Person.new    
    @person.build_address
    @person.build_occupation
    @person.occupation.build_address
    @person.build_driver_license
    @person.build_deficiency_person
  end

  # POST /people
  # POST /people.json
  def create
    @person = Person.new(person_params)
    @person.address.addressable = @person #<<<<<<<< Necessario
    @person.occupation.occupatiable = @person #<<<<<<<< Necessario
    @person.occupation.address.addressable = @person #<<<<<<<< Necessario
    @person.driver_license.licensable = @person #<<<<<<<< Necessario
    @person.deficiency_person.deficiencable = @person #<<<<<<<< Necessario
    respond_to do |format|
      if @person.save
        format.html { redirect_to admin_people_url, notice: 'Person was successfully created.' }
        format.json { render :show, status: :created, location: @person }
      else
        format.html { render :new }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def person_params
      params.require(:person).permit(:name, :email, :photo, :date_born, :date_enroll, :height, :rg, :cpf, :telephone_residence, :smartphone_number, :telephone_message, :message_person, :facebook, :father_name, :mother_name, :category_id, :marital_state_id, :wifes_name, :among_sun, :degree_education_id, :course, :motive, :complementary_information, :fingerprint, :address_attributes => [:addressable_id, :addressable_type, :zip_code, :street, :number, :complement, :reference, :neighbourhood, :city_id], :driver_license_attributes => [:licensable_id, :licensable_type, :number, :category, :date_issue, :expering_date], :occupation_attributes =>[:occupatiable_id, :occupatiable_type, :description, :experience_time], :deficiency_person_attributes => [:deficiencable_id, :deficiencable_type, :chronic_disease, :controlled_medication] )
    end

end
