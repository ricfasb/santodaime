class Admin::CheckinsController < Admin::AdminController
  
  layout "admin"

  require 'jasper-bridge'

  include ApplicationHelper
  include Jasper::Bridge
  
  before_action :set_checkins, only: [:checkins_pdf]
  before_action :set_without_checkins, only: [:without_checkins_pdf]

  before_action :authenticate_user!
  
  # GET /checkins
  # GET /checkins.json
  def index
    params[:q] ||= {}
    if params[:q][:created_at_lteq].present?
      params[:q][:created_at_lteq] = params[:q][:created_at_lteq].to_date.end_of_day
    end
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

  def without_checkins_pdf
    xml_data = render_to_string('checkins_nok.xml.builder', layout: false)    
    @company = Company.find( session[:current_company] )      
    @di = format_dt @init_date.to_s
    @df = format_dt @end_date.to_s
    encoded_string = Base64.encode64("DI#VLR##{@di}#RS#DF#VLR##{@df}#RS#")
    send_doc(xml_data, '/people/person', 'sem_checkin.jasper', "Relatório de pessoas sem registro de checkin", encoded_string, "pdf")
  end

  def checkins_pdf
    xml_data = render_to_string('checkins_ok.xml.builder', layout: false)    
    @company = Company.find( session[:current_company] )      
    @di = format_dt @init_date.to_s
    @df = format_dt @end_date.to_s
    encoded_string = Base64.encode64("DI#VLR##{@di}#RS#DF#VLR##{@df}#RS#")
    send_doc(xml_data, '/checkins/checkin', 'checkins.jasper', "Checkins Realizados", encoded_string, "pdf")
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def checkin_params
      params.require(:checkin).permit(:person_id, :company_id, :fingerprint)
    end

    def set_checkins     
      @init_date = format_date_hour_ini_us params[:initial_date]
      @end_date  = format_date_hour_fin_us params[:final_date]
      
      @checkins = Checkin.where(:created_at => @init_date..@end_date).order('created_at DESC')
    end

    def set_without_checkins     
      @init_date = format_date_hour_ini_us params[:initial_date]
      @end_date  = format_date_hour_fin_us params[:final_date]
                
      @people = Person.people_has_no_checkin(@init_date, @end_date)      
    end

end
