class AdminController < ActionController::Base

    def index
      @categories = Category.all
      @backgrounds = Background.all
      @users = User.all
      render layout: 'form'
    end
    
end
