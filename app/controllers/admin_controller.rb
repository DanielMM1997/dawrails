class AdminController < ActionController::Base
  include ApplicationHelper
    def index
      if logged_in?
        if current_user.type == 1
          @categories = Category.all
          @backgrounds = Background.all
          @users = User.all
          render layout:"form"
        else
          redirect_to welcome_path
        end
      else
        redirect_to welcome_path
      end
    end

    def newUser 
      if logged_in?
        if current_user.type == 1
          @user = User.new
          render layout:"form"
        else
          redirect_to welcome_path
        end
      else
        redirect_to welcome_path
      end
    end

    def createUser
      if logged_in?
        if current_user.type == 1
          @user = User.create(params.require(:user).permit(:nickname, :email, :password, :type))
          redirect_to admin_index_path
        else
          redirect_to welcome_path
        end
      else
        redirect_to welcome_path
      end
    end
end
