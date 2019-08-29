class Admin::CategoriesController < Admin::AdminController
 
  layout "admin"

  before_action :set_category, only: [:show, :edit, :update, :destroy]
  before_action :set_category_tuition, only: [:destroy_category_tuition]
  before_action :authenticate_user!
  
  # GET /categories
  # GET /categories.json
  def index
    @q = Category.ransack(params[:q])
    @q.sorts = 'id' if @q.sorts.blank?
    @categories = @q.result.paginate(:page => params[:page], :per_page => 10)        
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
  end

  # GET /categories/new
  def new
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit    
  end

  # POST /categories
  # POST /categories.json
  def create
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to admin_categories_url, notice: 'Categoria criada com sucesso' }
        format.json { render :show, status: :created, location: @category }        
      else
        format.html { render :new }
        format.json { render json: @category.errors, status: :unprocessable_entity }
        format.js   { render action: 'message' }
      end
    end
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to admin_categories_url, notice: 'Categoria atualizada com sucesso.' }
        format.json { head :no_content }
      else
        format.html { render :edit }
        format.json { render json: @category.errors, status: :unprocessable_entity }
        format.js   { render action: 'message'}
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    if @category.description == "Fardado"
      respond_to do |format|
        format.html { redirect_to admin_categories_url, notice: 'Categoria do sistema, não permite exclusão.' }        
        @category.errors.add("Atenção " "Categoria do sistema, não permite exclusão", "" "!")
        format.js { render action: 'message' }
      end
    else
      @category.destroy
      respond_to do |format|
        format.html { redirect_to admin_categories_url, notice: 'Categoria removida com sucesso.' }
        format.json { head :no_content }
      end
    end
  end

  def destroy_category_tuition
    respond_to do |format|
      if @category_tuition.destroy
        format.js
        render json: {}, status: :created
      else
        format.js
        render json: @category_tuition.errors, status: :unprocessable_entity
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])      
    end

    def set_category_tuition
      @category_tuition = CategoryTuition.find(params[:category_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:category).permit(:id, :description, category_tuitions_attributes: [:id, :tuition_id, :_destroy])
    end

end
