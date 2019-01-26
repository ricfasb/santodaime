class Admin::UsersController < Admin::AdminController
    
    before_action :authenticate_user!

    def index        
        @users = User.all
    end 

    
end