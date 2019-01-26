class Admin::CompaniesController < Admin::AdminController
  protect_from_forgery with: :null_session
  
  layout "admin"

  before_action :set_company, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:get_cep, :load_cities]


  def get_cep
    @address = ViaCep::Address.new(params[:cep])
    @state   = State.where(uf: @address.state)
    @city    = City.where(name: @address.city)    
    @cities  = City.where(state_id: 18)  

    if request.xhr?
      render :json => { :address => @address, :state => @state, :city => @city, :cities => @cities }
    else
      render json: {}, status: :false
    end
  end

  def load_cities
    @cities = City.where("state_id = ?", params[:state_id]).order('name ASC')
    if request.xhr?
      render :json => @cities
    else
      render json: {}, status: :false
    end
  end
  
  # GET /companies
  # GET /companies.json
  def index
    @q = Company.ransack(params[:q])
    @companies = @q.result.paginate(:page => params[:page], :per_page => 10)
  end

  # GET /companies/1
  # GET /companies/1.json
  def show
  end

  # GET /companies/new
  def new
    @company = Company.new
    @company.build_address
  end

  # GET /companies/1/edit
  def edit
  end

  # POST /companies
  # POST /companies.json
  def create
    @company = Company.new(company_params)
    @company.address.addressable = @company #<<<<<<<< Necessario
    respond_to do |format|
      if @company.save
        format.html { redirect_to admin_companies_url, notice: 'Sede cadastrada com sucesso.' }
        format.json { render :index, status: :created, location: @company }
      else
        format.html { render :new }
        format.json { render json: @company.errors, status: :unprocessable_entity }
        format.js   { render action: 'message' }
      end
    end
  end

  # PATCH/PUT /companies/1
  # PATCH/PUT /companies/1.json
  def update
    respond_to do |format|
      if @company.update(company_params)
        format.html { redirect_to admin_companies_url, notice: 'Sede atualizada com sucesso.' }
        format.json { head :no_content }
      else
        format.html { render :edit }
        format.json { render json: @company.errors, status: :unprocessable_entity }
        format.js   { render action: 'message' }
      end
    end
  end

  # DELETE /companies/1
  # DELETE /companies/1.json
  def destroy
    @company.destroy
    respond_to do |format|
      format.html { redirect_to admin_companies_url, notice: 'Sede removida com sucesso.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company
      @company = Company.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def company_params
      params.require(:company).permit(:name, :telephone, :address_attributes => [:addressable_id, :addressable_type, :zip_code, :street, :number, :complement, :reference, :neighbourhood, :city_id, :state_id])
    end
end
