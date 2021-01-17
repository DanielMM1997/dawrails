class CategoriesController < ActionController::Base
  include ApplicationHelper
  before_action :find_category, only: [:show, :update, :destroy, :edit, :find_backgrounds]

  def index
    render json:Category.all
  end
      
  def show
    @categories = Category.all
    @backgrounds = @category.backgrounds
    render layout:"application"
    #render json: {status:'SECCESS', message:'Category updated', data:@backgrounds, status: :ok}
  end

  def showAllRecientes
    @categories = Category.all
    @backgrounds = Background.all.order('created_at DESC')
    render layout: 'application'
  end

  def showAllDestacados
    @categories = Category.all
    @backgrounds = Background.all.order('created_at ASC')
    render layout: 'application'
  end

  def new
    if logged_in?
      if current_user.type == 1
        @category = Category.new
        render layout:"form"
      else
        redirect_to welcome_path
      end
    else
      redirect_to welcome_path
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
    if logged_in?
      if current_user.type == 1
        @category = Category.create(params.require(:category).permit(:name))
        redirect_to admin_index_path
      else
        redirect_to welcome_path
      end
    else
      redirect_to welcome_path
    end
  end
      
  def update
    if logged_in?
      if current_user.type == 1
        @category.name = params[:name]
        if @category.save
          redirect_to admin_index_path
        else
          render json: {status:'ERROR', message:'Category not updated', data:@category.errors, status: :unprocessable_entity}
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
        @category.destroy
        redirect_to admin_index_path
      else
        redirect_to welcome_path
      end
    else
      redirect_to welcome_path
    end
  end

  def find_backgrounds
    backgrounds = @category.backgrounds
    render json: {status:'SECCESS', message:'Category updated', data:backgrounds, status: :ok}
  end
      
  private
  def get_params
    params.require(:category).permit(:name)
  end
      
  def find_category
    @category = Category.find(params[:id])
  end
      
end
