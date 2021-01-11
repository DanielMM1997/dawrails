class WelcomeController < ActionController::Base
  def index
    @categories = Category.all
    render layout:"application"
  end
end
