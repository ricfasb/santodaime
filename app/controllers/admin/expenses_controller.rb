class Admin::ExpensesController < Admin::AdminController

  layout 'admin'

  before_action :set_expense, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  
  # GET /expenses
  # GET /expenses.json
  def index    
    @q = Expense.ransack(params[:q])
    @expenses = @q.result.paginate(:page => params[:page], :per_page => 10).order('created_at DESC')
  end

  # GET /expenses/1
  # GET /expenses/1.json
  def show
  end

  # GET /expenses/new
  def new
    @expense = Expense.new
  end

  # GET /expenses/1/edit
  def edit
  end

  # POST /expenses
  # POST /expenses.json
  def create
    @expense = Expense.new(expense_params)

    respond_to do |format|
      if @expense.save
        format.html { redirect_to admin_expenses_path, notice: 'Despesa cadastrada com sucesso.' }
        format.json { render :show, status: :created, location: @expense }
      else
        format.html { render :new }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
        format.js   { render action: 'message' }
      end
    end
  end

  # PATCH/PUT /expenses/1
  # PATCH/PUT /expenses/1.json
  def update
    respond_to do |format|
      if @expense.update(expense_params)
        format.html { redirect_to admin_expenses_path, notice: 'Despesa atualizada com sucesso.' }
        format.json { render :show, status: :ok, location: @expense }
      else
        format.html { render :edit }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
        format.js   { render action: 'message' }
      end
    end
  end

  # DELETE /expenses/1
  # DELETE /expenses/1.json
  def destroy
    @expense.destroy
    respond_to do |format|
      format.html { redirect_to admin_expenses_path, notice: 'Despesa removida com sucesso.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_expense
      @expense = Expense.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def expense_params
      params.require(:expense).permit(:company_id, :description, :observation, :provider, :amount)
    end
end
