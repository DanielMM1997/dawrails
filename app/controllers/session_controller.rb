class SessionController < ActionController::Base
  
  require 'digest'
  def index
      render layout: 'application'
  end
  
  def login
      @categories = Category.all
      render layout: 'application'
  end

  def create
    @user = User.find_by(nickname: params[:nickname])
    if @user && @user.authenticate(params[:nickname])
       sessions[:user_id] = @user.id
       redirect_to welcome_path
    else
       redirect_to login_path
    end
  end
  

  def registro
      @categories = Category.all
      render layout: 'application'
  end
  
end
