class Admin::PeopleController < Admin::AdminController
  
  require 'base64'
  require 'io/console'
  require 'jasper-bridge'

  include Jasper::Bridge
  include ApplicationHelper
  
  layout "admin"

  before_action :set_person, only: [:show, :edit, :update, :destroy, :show_image]
  before_action :set_people, only: [:birthdays_month]
  before_action :set_people_without_fngerprint, only: [:without_fingerprint]
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
    @people = Person.all.where("fingerprint IS NOT NULL")
    #Base64.encode64(str)
    if request.xhr?      
      unless @people.nil?        
        render :json => { :people => @people.to_json(:only => [ :id, :name, :fingerprint ], :include => :category), 
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
    @people = @q.result.paginate(:page => params[:page], :per_page => 10)
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

#    if permission 22

      @person = Person.new(person_params)
      data = params[:data_uri]

      if data.present?
        image_data = Base64.decode64(data['data:image/png;base64,'.length .. -1])
        @person.photo_file = image_data

  #      IO.binwrite("#{Rails.root}/public/system/people/photos/photo.png", image_data)
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
  #      File.open("#{Rails.root}/public/system/people/photos/photo.png", 'wb') do |f|
  #        f.write image_data
  #      end    
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
  #      file = File.open("#{Rails.root}/public/system/people/photos/photo.png")
  #      @person.photo = file
  #      file.close
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
 #   end
  end

  # PATCH/PUT /people/1
  # PATCH/PUT /people/1.json
  def update
    if permission 23
      respond_to do |format|
        data = params[:data_uri]
      
        if data.present?
          image_data = Base64.decode64(data['data:image/png;base64,'.length .. -1])
          @person.photo_file = image_data
          params[:photo_file] = image_data
          person_params[:photo_file] = image_data
          
  #        dirname = File.dirname("#{Rails.root}/public/system/people/photos/photo.png")
  #        unless File.directory?(dirname)
  #          FileUtils.mkdir_p(dirname)
  #        end

  #        IO.binwrite("#{Rails.root}/public/system/people/photos/photo.png", image_data)                      
  #        File.open("#{Rails.root}/public/system/people/photos/photo.png", 'wb') do |f|
  #          f.write image_data
  #        end    

  #        file = File.open("#{Rails.root}/public/system/people/photos/photo.png")
  #        @person.photo = file
  #        file.close
        else
          @person.photo_file = nil
        end

        if @person.update(person_params)
          format.html { redirect_to admin_people_url, notice: 'Cadastro atualizado com sucesso.' }
          format.json { head :no_content }
        else
          format.html { redirect_to admin_people_url, notice: 'Cadastro não atualizado com sucesso.' }
          format.json { render json: @person.errors, status: :unprocessable_entity }
          format.js   { render action: 'message' }
        end
      end
    end
  end

  # DELETE /people/1
  # DELETE /people/1.json
  def destroy
    if permission 24
      @person.destroy
      respond_to do |format|
        format.html { redirect_to admin_people_url, notice: 'Cadastro removido com sucesso.' }
        format.json { head :no_content }
      end
    end
  end

  def birthdays_month
    xml_data = render_to_string('birthdays_month.xml.builder', layout: false)
    @company = Company.find(session[:current_company])  
    encoded_string = Base64.encode64("COMPANY_NAME#VLR##{@company.name}#RS#COMPANY_PHONE#VLR##{@company.telephone}#RS# ")
    send_doc(xml_data, '/people/person', 'birthdays_month.jasper', "Aniversariantes do mês", encoded_string, "pdf")  
  end

  def without_fingerprint
    xml_data = render_to_string('people.xml.builder', layout: false)
    @company = Company.find(session[:current_company])  
    encoded_string = Base64.encode64("COMPANY_NAME#VLR##{@company.name}#RS#COMPANY_PHONE#VLR##{@company.telephone}#RS# ")
    send_doc(xml_data, '/people/person', 'without_fingerprint.jasper', "Pessoas sem biometria", encoded_string, "pdf")  
  end

  def birthday   
    render :no_content 
  end

  def show_image    
    send_data @person.photo_file, :type => 'image/png', :disposition => 'inline'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_person
      @person = Person.find(params[:id])
    end

    def set_people
      @people = Person.where('date_born IS NOT NULL and EXTRACT(month FROM date_born) = ?', Time.now.month).order("EXTRACT(day FROM date_born) ASC")
    end

    def set_people_without_fngerprint      
      @people = Person.where("LENGTH(fingerprint) = 0").order("name ASC")   
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def person_params
      params.require(:person).permit(:name, :email, :photo, :photo_file, :date_born, :date_enroll, :height, :rg, :cpf, :telephone_residence, :smartphone_number, :telephone_message, :message_person, :facebook, :father_name, :mother_name, :category_id, :marital_state_id, :wifes_name, :among_sun, :degree_education_id, :course, :motive, :complementary_information, :fingerprint, :on_line, :address_attributes => [:addressable_id, :addressable_type, :zip_code, :street, :number, :complement, :reference, :neighbourhood, :city_id], :driver_license_attributes => [:licensable_id, :licensable_type, :number_cnh, :category_cnh, :date_issue, :expering_date], :occupation_attributes =>[:occupatiable_id, :occupatiable_type, :description, :experience_time, :address_attributes => [:addressable_id, :addressable_type, :zip_code, :street, :number, :complement, :reference, :neighbourhood, :city_id]], :deficiency_person_attributes => [:deficiencable_id, :deficiencable_type, :chronic_disease, :controlled_medication] )
    end

#    def photo_file
      #self.photo.url(:thumb)      
#      encoded_string = Base64.encode64(self.photo_file).read.encode('utf-8') 
#    end
  
end
