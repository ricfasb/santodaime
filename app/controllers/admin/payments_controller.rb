class Admin::PaymentsController < Admin::AdminController
  protect_from_forgery with: :null_session
  
  layout "admin"

  before_action :set_payment, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def get_all_debits
    @invoices = Invoice.where(pay_day: nil).where(cancel_date: nil).where(person_id: params[:person_id])
    @tuitions = TuitionPerson.where(pay_day: nil).where(cancel_date: nil).where(person_id: params[:person_id])
    @person_id = params[:person_id]
    if request.xhr?
      render :json => { :person => @person_id, :invoices => @invoices, :tuitions => @tuitions }
    else
      render json: {}, status: :false
    end
  end
 
  def get_debits
    @invoices = Invoice.where("due_date < ?", Date.today).where(pay_day: nil).where(person_id: params[:person_id])
    @tuitions = TuitionPerson.where("due_date < ?", Date.today).where(pay_day: nil).where(person_id: params[:person_id])
    @person_id = params[:person_id]
    if request.xhr?
      render :json => { :person => @person_id, :invoices => @invoices, :tuitions => @tuitions }
    else
      render json: {}, status: :false
    end
  end

  def get_actual_debits
    @invoices = Invoice.where("due_date < ?", Date.today).where(pay_day: nil).where(person_id: params[:person_id])
    @tuitions = TuitionPerson.where("due_date < ?", Date.today).where(pay_day: nil).where(person_id: params[:person_id])
    @person_id = params[:person_id]
    if request.xhr?
      render :json => { :person => @person_id, :invoices => @invoices, :tuitions => @tuitions }
    else
      render json: {}, status: :false
    end
  end

  def pay
    if request.xhr?
      render json: {}, status: :true
    else
      render json: {}, status: :false
    end
  end

  # GET /payments
  # GET /payments.json
  def index
    @q = Payment.ransack(params[:q])    
    @payments = @q.result.paginate(:page => params[:page], :per_page => 5)
  end

  # GET /payments/1
  # GET /payments/1.json
  def show
  end

  # GET /payments/new
  def new
    @payment = Payment.new
  end

  # GET /payments/1/edit
  def edit
  end

  # POST /payments
  # POST /payments.json
  def create
    params[:payments].each { |payment|  
      if params[:payments][payment][:cobranca] == "Multa"        
        @id = params[:payments][payment][:id]
        @payment_type = params[:payments][payment][:payment_type_id]
        @discount = params[:payments][payment][:discount]
        @person_paid = current_user.id
        Invoice.update(@id, pay_day: DateTime.now, payment_type_id: @payment_type, discount: @discount, person_paied: @person_paid)
      elsif params[:payments][payment][:cobranca] == "Mensalidade"        
        @id = params[:payments][payment][:id]
        @payment_type = params[:payments][payment][:payment_type_id]
        @discount = params[:payments][payment][:discount]
        @person_paid = current_user.id
        TuitionPerson.update(@id, pay_day: DateTime.now, status_payment: 'paid', payment_type_id: @payment_type, discount: @discount, person_paied: @person_paid)
      end
    }
    
    render :json => { :status => :ok }
    #@payment = Payment.new(payment_params)

    # respond_to do |format|
    #   if @payment.save
    #     format.html { redirect_to admin_payment_url, notice: 'Payment was successfully created.' }
    #     format.json { render :show, status: :created, location: @payment }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @payment.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /payments/1
  # PATCH/PUT /payments/1.json
  def update
    respond_to do |format|
      if @payment.update(payment_params)
        format.html { redirect_to @payment, notice: 'Payment was successfully updated.' }
        format.json { render :show, status: :ok, location: @payment }
      else
        format.html { render :edit }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /payments/1
  # DELETE /payments/1.json
  def destroy
    @payment.destroy
    respond_to do |format|
      format.html { redirect_to admin_payments_url, notice: 'Payment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_payment
      @payment = Payment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def payment_params
      params.require(:payment).permit(:person_id, :invoice_id, :due_date, :pay_day, :pay_amount, :discount, :obs_discount)
    end
end
