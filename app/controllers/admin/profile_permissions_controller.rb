class Admin::ProfilePermissionsController < Admin::AdminController

  layout 'admin'
  
  before_action :set_profile_permission, only: [:show, :edit, :update, :destroy]

  # GET /profile_permissions
  # GET /profile_permissions.json
  def index
    @profile_permissions = ProfilePermission.all
    @permissions = Permission.all
  end

  def get_permissions
    @profile_permissions = ProfilePermission.where(profile_id: params[:profile_id])

    if request.xhr?
      render :json => { :profile_permissions => @profile_permissions }
    else
      render json: {}, status: :false
    end

  end

  # GET /profile_permissions/1
  # GET /profile_permissions/1.json
  def show
  end

  # GET /profile_permissions/new
  def new
    @profile_permission = ProfilePermission.new
  end

  # GET /profile_permissions/1/edit
  def edit
  end

  # POST /profile_permissions
  # POST /profile_permissions.json
  def create
    @profile_permission = ProfilePermission.new(profile_permission_params)

    respond_to do |format|
      if @profile_permission.save
        format.html { redirect_to @profile_permission, notice: 'Profile permission was successfully created.' }
        format.json { render :show, status: :created, location: @profile_permission }
      else
        format.html { render :new }
        format.json { render json: @profile_permission.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /profile_permissions/1
  # PATCH/PUT /profile_permissions/1.json
  def update
    respond_to do |format|
      if @profile_permission.update(profile_permission_params)
        format.html { redirect_to @profile_permission, notice: 'Profile permission was successfully updated.' }
        format.json { render :show, status: :ok, location: @profile_permission }
      else
        format.html { render :edit }
        format.json { render json: @profile_permission.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /profile_permissions/1
  # DELETE /profile_permissions/1.json
  def destroy
    @profile_permission.destroy
    respond_to do |format|
      format.html { redirect_to profile_permissions_url, notice: 'Profile permission was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile_permission
      @profile_permission = ProfilePermission.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_permission_params
      params.require(:profile_permission).permit(:profile_id, :permission_id)
    end
end
