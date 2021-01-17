class AdminController < ActionController::Base
    def index
        @categories = Category.all
        @backgrounds = Background.all
        @users = User.all
        render layout:"form"
    end

    def newUser 
      @user = User.new
      render layout:"form"
    end

    def createUser
      @user = User.create(params.require(:user).permit(:nickname, :email, :password, :type))
      redirect_to admin_index_path
    end
end
