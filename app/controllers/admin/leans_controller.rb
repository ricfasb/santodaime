class Admin::LeansController < Admin::AdminController
  
  layout 'admin'

  require 'jasper-bridge'

  include ApplicationHelper
  include Jasper::Bridge
  
  #before_action :set_lean, only: [:show, :edit, :update, :destroy]
  before_action :set_lean, only: [:show, :edit, :update]
  
  before_action :set_leans, only: [:leans_pdf]
  before_action :set_returneds, only: [:returneds_pdf]

  before_action :authenticate_user!
  
  # GET /leans
  # GET /leans.json
  def index    
    @q = Lean.where(returned: [nil]).ransack(params[:q])
    @leans = @q.result.paginate(:page => params[:page], :per_page => 10).order('created_at DESC')
  end

  def get_leans_by_person
    @leans = Lean.where(person_id: params[:person_id]).where(returned: nil)
    if request.xhr?
      render :json => { :leans => @leans }
    else
      render json: {}, status: :false
    end
  end

  # GET /leans/1
  # GET /leans/1.json
  def show
  end

  # GET /leans/new
  def new
    @lean = Lean.new
  end

  # GET /leans/1/edit
  def edit
  end

  # POST /leans
  # POST /leans.json
  def create

    @errors = []
    @success = []

    params[:lean].each { |l|        
      @lean = Lean.new
      @lean.company_id = params[:lean][l][:company_id]
      @lean.product_id = params[:lean][l][:product_id]
      @lean.person_id = params[:lean][l][:person_id] 
      @lean.quantity = params[:lean][l][:quantity]
      @lean.expected_return = params[:lean][l][:expected_return]

      if @lean.save
        @product = Product.find(@lean.product_id)
        @quantity = @product.quantity - @lean.quantity
        @product.update(quantity: @quantity) 
        @success.push( @lean.product_id )
      else
        @errors.push( @lean.product_id )
      end      
    }

    respond_to do |format|
      format.js
      render json: { "errors": @errors, "products": @success}, status: :created
    end
  end

  # PATCH/PUT /leans/1
  # PATCH/PUT /leans/1.json
  def update    
    if @lean.update(lean_params)   
      @lean = Lean.find( params[:id] )
      @product = Product.find( @lean.product_id )
      @quantity = @product.quantity + @lean.quantity
      @product.update(quantity: @quantity)      

      puts "#{ @product }"
      puts "#{ lean_params }"
      render :json => { :status => :ok }       
    else
      render :json => { :status => :false }
    end
  end

  # DELETE /leans/1
  # DELETE /leans/1.json
#  def destroy
#    @lean.destroy
#    respond_to do |format|
#      format.html { redirect_to leans_url, notice: 'Lean was successfully destroyed.' }
#      format.json { head :no_content }
#    end
#  end

  def leans_pdf
    xml_data = render_to_string('leans.xml.builder', layout: false)    
    @company = Company.find( session[:current_company] )      
    @di = format_dt @init_date.to_s
    @df = format_dt @end_date.to_s
    encoded_string = Base64.encode64("DI#VLR##{@di}#RS#DF#VLR##{@df}#RS#")
    send_doc(xml_data, '/leans/lean', 'leans.jasper', "Relatório de Materiais Emprestados", encoded_string, "pdf")
  end

  def returneds_pdf
    xml_data = render_to_string('returneds.xml.builder', layout: false)    
    @company = Company.find( session[:current_company] )      
    @di = format_dt @init_date.to_s
    @df = format_dt @end_date.to_s
    encoded_string = Base64.encode64("DI#VLR##{@di}#RS#DF#VLR##{@df}#RS#")
    send_doc(xml_data, '/leans/lean', 'returneds.jasper', "Relatório de Materiais Devolvidos", encoded_string, "pdf")
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lean
      @lean = Lean.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lean_params
      params.require(:lean).permit(:id, :company_id, :person_id, :product_id, :quantity, :expected_return, :returned)
    end

    def set_leans 
      @init_date = format_date_hour_ini_us params[:initial_date]
      @end_date  = format_date_hour_fin_us params[:final_date]

      @leans = Lean.where(returned: nil).where(:expected_return => @init_date..@end_date)
    end

    def set_returneds
      @init_date = format_date_hour_ini_us params[:initial_date]
      @end_date  = format_date_hour_fin_us params[:final_date]
      
      @leans = Lean.where.not(returned: nil).where(:returned => @init_date..@end_date)      
    end
end
