class SessionController < ActionController::Base
  
  require 'digest'
  def index
      render layout: 'application'
  end
  
  def new
      @categories = Category.all
      render layout: 'form'
  end

  def create
    @user = User.find_by(nickname: params[:nickname])
    @pass = params[:password]
    @pass = Digest::SHA256.new << @pass
    if @pass == @user.password
       session[:user_id] = @user.id
       flash[:success] = 'Has iniciado sesión como ' + @user.nickname
       if @user.type == 1
        redirect_to admin_index_path
       else
        redirect_to welcome_path
       end
    else
      flash[:danger] = 'Las credenciales proporcionadas no corresponden a ningún usuario.'
      redirect_to login_path
    end
  end
  

  def registro
      @categories = Category.all
      render layout: 'application'
  end
  
end
