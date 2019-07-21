class Admin::InvoicesController < Admin::AdminController
  protect_from_forgery with: :null_session
  
  layout "admin"

  before_action :set_invoice, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /invoices
  # GET /invoices.json
  def index
    @q = Invoice.where(pay_day: [nil]).ransack(params[:q])
    @invoices = @q.result.paginate(:page => params[:page], :per_page => 10).order('created_at DESC')
  end

  # GET /invoices/1
  # GET /invoices/1.json
  def show
  end

  # GET /invoices/new
  def new
    @invoice = Invoice.new
  end

  # GET /invoices/1/edit
  def edit
  end

  # POST /invoices
  # POST /invoices.json
  def create
    @invoice = Invoice.new(invoice_params)

    respond_to do |format|
      if @invoice.save
        format.html { redirect_to admin_invoices_url, notice: 'Cobrança adicionada com sucesso.' }
        format.json { render :show, status: :created, location: @invoice }
      else
        format.html { render :new }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
        format.js   { render action: 'message' }
      end
    end
  end

  # PATCH/PUT /invoices/1
  # PATCH/PUT /invoices/1.json
  def update
    respond_to do |format|
      if @invoice.update(invoice_params)
        format.html { redirect_to admin_invoices_url, notice: 'Cobrança atualizada com sucesso.' }
        format.json { head :no_content }
      else
        format.html { render :edit }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
        format.js   { render action: 'message'}
      end
    end
  end

  # DELETE /invoices/1
  # DELETE /invoices/1.json
  def destroy
    @invoice.destroy
    respond_to do |format|
      format.html { redirect_to admin_invoices_url, notice: 'Cobrança apagada.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_invoice
      @invoice = Invoice.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def invoice_params
      params.require(:invoice).permit(:person_id, :invoice_type_id, :description, :due_date, :amount)
    end
end
