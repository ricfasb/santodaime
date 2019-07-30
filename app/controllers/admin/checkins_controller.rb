class Admin::CheckinsController < Admin::AdminController
  
  layout "admin"
  
  before_action :authenticate_user!

  
  # GET /checkins
  # GET /checkins.json
  def index
    @q = Checkin.ransack(params[:q])
    @q.sorts = ['created_at desc'] if @q.sorts.empty?
    @checkins = @q.result.paginate(:page => params[:page], :per_page => 10)  
  end

  # GET /checkins/new
  def new
    @checkin = Checkin.new
  end

  # POST /checkins
  # POST /checkins.json
  def create
    @checkin = Checkin.new(checkin_params)

    respond_to do |format|
      if @checkin.save
        format.js
        render json: {}, status: :created
      else
        format.js
        render json: @checkin.errors, status: :unprocessable_entity
      end
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def checkin_params
      params.require(:checkin).permit(:person_id, :company_id, :fingerprint)
    end
end
