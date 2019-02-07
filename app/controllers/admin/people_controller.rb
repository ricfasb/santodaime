class Admin::PeopleController < Admin::AdminController
  
  require 'base64'
  require 'io/console'
  require 'jasper-bridge'

  include Jasper::Bridge
  
  layout "admin"

  before_action :set_person, only: [:show, :edit, :update, :destroy]
  before_action :set_people, only: [:birthdays_month, :exportar_pdf]
  before_action :authenticate_user!, :except => [:get_cep, :create, :search_by_email, :show]

  def search_person
    @person = Person.where(id: params[:person_id])
    if request.xhr?  
      unless @person.nil?
        render :json => { :person => @person }
      end
    else
      render json: {}, status: :false
    end
  end
  
  def search_fingerprint    
    @people = Person.all

    if request.xhr?      
      unless @people.nil?
        render :json => { :people => @people.to_json(:include => :category, :methods => [:photo]),                        
                          :message => 'OK' }
      end
    else
      render json: {}, status: :false
    end
  end

  def get_cep
    @address = ViaCep::Address.new(params[:cep])
    @state = State.where(uf: @address.state)
    @city = City.where(name: @address.city)

    if request.xhr?
      render :json => { :address => @address, 
                        :state => @state, 
                        :city => @city
                      }
    else
      render json: {}, status: :false
    end
  end

  def load_cities
    @cities = City.where("state_id = ?", params[:state_id])
    if request.xhr?
      render :json => @cities
    else
      render json: {}, status: :false
    end
  end

  def search_by_email
    @person = Person.find_by_email(email: params[:email])
      if request.xhr?
          render :json => @person
      else
         render :nothing => true
      end
  end

  # GET /people
  # GET /people.json
  def index
    @q = Person.ransack(params[:q])
    @people = @q.result.paginate(:page => params[:page], :per_page => 5)
  end

  # GET /people/1
  # GET /people/1.json
  def show
  end

  # GET /people/new
  def new
    @person = Person.new
    @person.build_address
    @person.build_occupation
    @person.occupation.build_address
    @person.build_driver_license
    @person.build_deficiency_person
  end

  # GET /people/1/edit
  def edit
    @tuitionPeople = TuitionPerson.where(person_id: params[:id])    
  end

  # POST /people
  # POST /people.json
  def create
    @person = Person.new(person_params)
    data = params[:data_uri]

    if data.present?
      image_data = Base64.decode64(data['data:image/png;base64,'.length .. -1])

      IO.binwrite("#{Rails.root}/public/system/people/photos/photo.png", image_data)
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      
      File.open("#{Rails.root}/public/system/people/photos/photo.png", 'wb') do |f|
        f.write image_data
      end    
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      
      file = File.open("#{Rails.root}/public/system/people/photos/photo.png")
      @person.photo = file
      file.close
    end

    @person.address.addressable = @person #<<<<<<<< Necessario
    @person.occupation.occupatiable = @person #<<<<<<<< Necessario
    @person.occupation.address.addressable = @person.occupation #<<<<<<<< Necessario
    @person.driver_license.licensable = @person #<<<<<<<< Necessario
    @person.deficiency_person.deficiencable = @person #<<<<<<<< Necessario

    # encoded_photo = person_params[:data]
    # content_type = person_params[:content_type]
    # image = Paperclip.io_adapters.for("data:#{content_type};base64,#{encoded_photo}")
    # image.original_filename = person_params[:filename]
    # @person.photo = image

    respond_to do |format|
      if @person.save        
        format.html { redirect_to admin_people_url, notice: 'Cadastro realizado com sucesso.' }        
        if params.has_key?(:on_line)
          format.js   { render action: 'message' }
        else
          format.json { render :show, status: :ok, location: @person }
        end        
      else 
        format.html { render :new }
        format.json { render json: @person.errors, status: :unprocessable_entity }   
        format.js   { render action: 'message' }     
      end
    end
  end

  # PATCH/PUT /people/1
  # PATCH/PUT /people/1.json
  def update
    respond_to do |format|
      data = params[:data_uri]

      if data.present?
        image_data = Base64.decode64(data['data:image/png;base64,'.length .. -1])

        IO.binwrite("#{Rails.root}/public/system/people/photos/photo.png", image_data)
      
        File.open("#{Rails.root}/public/system/people/photos/photo.png", 'wb') do |f|
          f.write image_data
        end    

        file = File.open("#{Rails.root}/public/system/people/photos/photo.png")
        @person.photo = file
        file.close
      end

      if @person.update(person_params)
        format.html { redirect_to admin_people_url, notice: 'Cadastro atualizado com sucesso.' }
        format.json { head :no_content }
      else
        format.html { render :edit }
        format.json { render json: @person.errors, status: :unprocessable_entity }
        format.js   { render action: 'message' }
      end
    end
  end

  # DELETE /people/1
  # DELETE /people/1.json
  def destroy
    @person.destroy
    respond_to do |format|
      format.html { redirect_to admin_people_url, notice: 'Cadastro removido com sucesso.' }
      format.json { head :no_content }
    end
  end

  def exportar_pdf
    xml_data = render_to_string('birthdays_month.xml.builder', layout: false)
    @company = Company.find(2)  
    encoded_string = Base64.encode64("#{@company.name}#RS##{@company.telephone}#RS# ")
    send_doc(xml_data, '/people/person', 'birthdays_month.jasper', "Aniversariantes do mês", encoded_string, "pdf")  
  end

  def birthdays_month    
    render('birthday.xml.builder', layout: false)
  end

  def birthday   
    render :no_content 
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_person
      @person = Person.find(params[:id])
    end

    def set_people
      @people = Person.all      
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def person_params
      params.require(:person).permit(:name, :email, :photo, :date_born, :date_enroll, :height, :rg, :cpf, :telephone_residence, :smartphone_number, :telephone_message, :message_person, :facebook, :father_name, :mother_name, :category_id, :marital_state_id, :wifes_name, :among_sun, :degree_education_id, :course, :motive, :complementary_information, :fingerprint, :on_line, :address_attributes => [:addressable_id, :addressable_type, :zip_code, :street, :number, :complement, :reference, :neighbourhood, :city_id], :driver_license_attributes => [:licensable_id, :licensable_type, :number, :category, :date_issue, :expering_date], :occupation_attributes =>[:occupatiable_id, :occupatiable_type, :description, :experience_time, :address_attributes => [:addressable_id, :addressable_type, :zip_code, :street, :number, :complement, :reference, :neighbourhood, :city_id]], :deficiency_person_attributes => [:deficiencable_id, :deficiencable_type, :chronic_disease, :controlled_medication] )
    end

    def photo
      self.photo.url(:thumb)
    end
end
