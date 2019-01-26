class Admin::InvoiceTypesController < ApplicationController

  skip_before_filter :verify_authenticity_token
  
  before_action :set_admin_invoice_type, only: [:show, :edit, :update, :destroy]

  # GET /admin/invoice_types
  # GET /admin/invoice_types.json
  def index
    @admin_invoice_types = Admin::InvoiceType.all
  end

  # GET /admin/invoice_types/1
  # GET /admin/invoice_types/1.json
  def show
  end

  # GET /admin/invoice_types/new
  def new
    @admin_invoice_type = Admin::InvoiceType.new
  end

  # GET /admin/invoice_types/1/edit
  def edit
  end

  # POST /admin/invoice_types
  # POST /admin/invoice_types.json
  def create
    @admin_invoice_type = Admin::InvoiceType.new(admin_invoice_type_params)

    respond_to do |format|
      if @admin_invoice_type.save
        format.html { redirect_to @admin_invoice_type, notice: 'Invoice type was successfully created.' }
        format.json { render :show, status: :created, location: @admin_invoice_type }
      else
        format.html { render :new }
        format.json { render json: @admin_invoice_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/invoice_types/1
  # PATCH/PUT /admin/invoice_types/1.json
  def update
    respond_to do |format|
      if @admin_invoice_type.update(admin_invoice_type_params)
        format.html { redirect_to @admin_invoice_type, notice: 'Invoice type was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_invoice_type }
      else
        format.html { render :edit }
        format.json { render json: @admin_invoice_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/invoice_types/1
  # DELETE /admin/invoice_types/1.json
  def destroy
    @admin_invoice_type.destroy
    respond_to do |format|
      format.html { redirect_to admin_invoice_types_url, notice: 'Invoice type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_invoice_type
      @admin_invoice_type = Admin::InvoiceType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_invoice_type_params
      params.require(:admin_invoice_type).permit(:description)
    end
end
