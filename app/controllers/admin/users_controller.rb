class Admin::UsersController < Admin::AdminController
    
    layout 'admin'

    before_action :set_user, only: [:update]
    before_action :authenticate_user!, except: [:create_session]

    def index        
        @users = User.all
    end 

    def update               
      @user.update(user_params)
      if request.xhr?
        render :json => { :profile => @user.profile.description }
      else
        render json: {}, status: :false
      end
    end

    def create_session
      session[:current_company] = params[:company_id]
      if request.xhr?
        render json: {}, status: :created
      else
        render json: {}, status: :false
      end
    end    

    private
      def set_user
        @user = User.find(params[:user][:id])        
      end
      
      def user_params
        params.require(:user).permit(:id, :profile_id)
      end
end