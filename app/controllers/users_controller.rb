class UsersController < ActionController::Base

  require 'digest'
  before_action :find_user, only: [:show, :update, :destroy, :edit]

  def index
    render json:User.all
  end

  def new
    @user = User.new
    @categories = Category.all
    render layout:"form"
  end
      
  def show
    @categories = Category.all
    @backgrounds = @user.backgrounds
    @own_backgrounds = @user.own_backgrounds
    render layout:"application"
  end

  def edit
    render layout:"form"
  end
      
  def create
    @user = User.create(params.require(:user).permit(:nickname, :email, :password, :type))
    session[:user_id] = @user.id
    redirect_to welcome_path
  end
      
  def update
    if @user.update(get_params)
      render json: {status:'SECCESS', message:'User update', data:user, status: :ok}
    else
      render json: {status:'ERROR', message:'User not updated', data:User.errors, status: :unprocessable_entity}
    end
  end
      
  def destroy
    @user.destroy
    render json: {status:'SECCESS', message:'User deleted', data:@user, status: :ok}
  end
      
  def login
    user = User.find_by_email(params[:email])
    digestPasword =  Digest::SHA2.hexdigest params[:password]
    if user.password == digestPasword
      render json: {status: "SUCCESS", message: "User login", data:user}, status: :ok
    else
      render json: {status: 'ERROR', message:'user not valid'},status: :bad_request
    end
  end

  def logout
    session[:user_id] = nil
    flash[:warning] = 'Has cerrado la sesión'
    redirect_to welcome_path
  end

  private
  def get_params
    params.required(:User).permit(:nickname, :email, :password)
  end
      
  def find_user
    @user = User.find(params[:id])
  end
end
