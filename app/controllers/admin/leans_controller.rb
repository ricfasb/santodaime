class Admin::LeansController < Admin::AdminController
  
  layout 'admin'
  
  #before_action :set_lean, only: [:show, :edit, :update, :destroy]
  before_action :set_lean, only: [:show, :edit, :update]
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lean
      @lean = Lean.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lean_params
      params.require(:lean).permit(:id, :company_id, :person_id, :product_id, :quantity, :expected_return, :returned)
    end
end
