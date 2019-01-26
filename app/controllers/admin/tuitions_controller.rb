class Admin::TuitionsController < Admin::AdminController
  
  protect_from_forgery with: :exception
  
  layout "admin"
  
  before_action :set_tuition, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!  

  # GET /tuitions
  # GET /tuitions.json
  def index
    @tuitions = Tuition.all
  end

  # GET /tuitions/1
  # GET /tuitions/1.json
  def show
  end

  # GET /tuitions/new
  def new
    @tuition = Tuition.new
  end

  # GET /tuitions/1/edit
  def edit
  end

  # POST /tuitions
  # POST /tuitions.json
  def create
    @tuition = Tuition.new(tuition_params)

    respond_to do |format|
      if @tuition.save
        format.html { redirect_to admin_tuitions_url, notice: 'Mensalidade cadastrada com sucesso.' }
        format.json { render :show, status: :created, location: @tuition }        
      else
        format.html { render :new }
        format.json { render json: @tuition.errors, status: :unprocessable_entity }        
        format.js   { render action: 'message' }  
      end
    end
  end

  # PATCH/PUT /tuitions/1
  # PATCH/PUT /tuitions/1.json
  def update
    respond_to do |format|
      if @tuition.update(tuition_params)
        format.html { redirect_to admin_tuitions_url, notice: 'Mensalidade atualizada com sucesso' }
        format.json { head :no_content }
      else
        format.html { render :edit }
        format.json { render json: @tuition.errors, status: :unprocessable_entity }
        format.js   { render action: 'message'}
      end
    end
  end

  # DELETE /tuitions/1
  # DELETE /tuitions/1.json
  def destroy
    @tuition.destroy
    respond_to do |format|
      format.html { redirect_to admin_tuitions_url, notice: 'Mensalidade removida com sucesso.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tuition
      @tuition = Tuition.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tuition_params
      params.require(:tuition).permit(:description, :send_email, :day, :amount, :day_email, :email_id)
    end
end
