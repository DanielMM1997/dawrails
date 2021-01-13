class SessionController < ActionController::Base
  
  require 'digest'
  def index
      render layout: 'application'
  end
  
  def login
      @categories = Category.all
      render layout: 'application'
  end

  def checkLogin
      user = User.find_by_email(params[:email])
      puts params[:email]
      puts params[:password]
      puts 'asdasdasd'
      digestPasword =  Digest::SHA2.hexdigest params[:password]
      if user.password == params[:password]
          session[:email] = user.email
          session[:token] = user.token
          redirect_to welcome_path
      else
          redirect_to login
      end
  end
  

  def registro
      @categories = Category.all
      render layout: 'application'
  end
  
end
