class UsersController < ActionController::Base
  include ApplicationHelper
  require 'digest'
  before_action :find_user, only: [:show, :update, :destroy, :edit]

  def index
    render json:User.all
  end

  def new
    @user = User.new
    render layout:"form"
  end
      
  def show
    if logged_in?
      @categories = Category.all
      @backgrounds = @user.backgrounds
      @own_backgrounds = @user.own_backgrounds.order('created_at DESC')
      render layout:"application"
    else
      redirect_to login_path
    end  
  end

  def edit
    if logged_in?
      if current_user.type == 1
        render layout:"form"
      else
        redirect_to welcome_path
      end
    else
      redirect_to welcome_path
    end
  end
      
  def create
    @user = User.create(params.require(:user).permit(:nickname, :email, :password, :type))
    session[:user_id] = @user.id
    redirect_to welcome_path
  end
      
  def update
    if logged_in?
      if current_user.type == 1
        @user.nickname = params[:nickname]
        @user.email = params[:email]
        if !params[:password].blank?
        @user.password = params[:password]
        @user.password = Digest::SHA256.new << @user.password
        end
        @user.type = params[:type]
        if @user.save
          redirect_to admin_index_path
        else
          render json: {status:'ERROR', message:'User not updated', data:params, status: :unprocessable_entity}
        end
      else
        redirect_to welcome_path
      end
    else
      redirect_to welcome_path
    end
  end
      
  def destroy
    if logged_in?
      if current_user.type == 1
        @user.destroy
        redirect_to admin_index_path
      else
        redirect_to welcome_path
      end
    else
      redirect_to welcome_path
    end
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
    params.require(:user).permit(:nickname, :email, :password)
  end
      
  def find_user
    @user = User.find(params[:id])
  end
end
