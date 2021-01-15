class AdminController < ActionController::Base
    def index
        @categories = Category.all
        @backgrounds = Background.all
        @users = User.all
        render layout:"form"
    end

    def newUser 
      render layout:"form" 
      @user = User.create(params.require(:user).permit(:nickname, :email, :password, :type))
      session[:user_id] = @user.id
      redirect_to welcome_path
    end

    def newCategory
      render layout:"form"
      category = Category.new(get_params)
      if category.save
        render json: {status:'SECCESS', message:'Category saved', data:category, status: :ok}
      else
        render json: {status:'ERROR', message:'Category not saved', data:Category.errors, status: :unprocessable_entity}
      end
    end
    
end
