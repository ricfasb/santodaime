class Admin::InvoiceTypesController < Admin::AdminController
  protect_from_forgery with: :null_session
  
  before_action :set_invoice_type, only: [:show, :edit, :update, :destroy]

  layout 'admin'
  # GET /admin/invoice_types
  # GET /admin/invoice_types.json
  def index
    @invoice_types = InvoiceType.all
    @invoice_type = InvoiceType.new
  end

  # GET /admin/invoice_types/1/edit
  def edit
    @invoice_types = InvoiceType.all
  end

  # POST /admin/invoice_types
  # POST /admin/invoice_types.json
  def create
    @invoice_type = InvoiceType.new(invoice_type_params)

    respond_to do |format|
      if @invoice_type.save
        format.html { redirect_to admin_invoice_types_path, notice: 'Tipo de cobrança criado com sucesso.' }
        format.json { render :index, status: :created, location: @invoice_type }
      else
        format.html { render :new }
        format.json { render json: @invoice_type.errors, status: :unprocessable_entity }
        format.js   { render action: 'message' }
      end
    end
  end

  # PATCH/PUT /admin/invoice_types/1
  # PATCH/PUT /admin/invoice_types/1.json
  def update
    respond_to do |format|
      if @invoice_type.update(invoice_type_params)
        format.html { redirect_to admin_invoice_types_path, notice: 'Tipo de cobrança atualizado com sucesso.' }
        format.json { render :index, status: :ok, location: @invoice_type }
      else
        format.html { render :edit }
        format.json { render json: @invoice_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/invoice_types/1
  # DELETE /admin/invoice_types/1.json
  def destroy
    @invoice_type.destroy
    respond_to do |format|
      format.html { redirect_to admin_invoice_types_path, notice: 'Tipo de cobrança removido com sucesso.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_invoice_type
      @invoice_type = InvoiceType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def invoice_type_params
      params.require(:invoice_type).permit(:description)
    end
end
