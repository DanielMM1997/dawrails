class CategoriesController < ActionController::Base

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

  def edit
    render layout:"form"
  end
      
  def create
    category = Category.new(get_params)
    if category.save
      render json: {status:'SECCESS', message:'Category saved', data:category, status: :ok}
    else
      render json: {status:'ERROR', message:'Category not saved', data:Category.errors, status: :unprocessable_entity}
    end
  end
      
  def update
    if @category.update(get_params)
      render json: {status:'SECCESS', message:'Category updated', data:category, status: :ok}
    else
      render json: {status:'ERROR', message:'Category not updated', data:Category.errors, status: :unprocessable_entity}
    end
  end
      
  def destroy
    @category.destroy
    render json: {status:'SECCESS', message:'Category deleted', data:@category, status: :ok}
  end

  def find_backgrounds
    backgrounds = @category.backgrounds
    render json: {status:'SECCESS', message:'Category updated', data:backgrounds, status: :ok}
  end
      
  private
  def get_params
    params.required(:Category).permit(:name)
  end
      
  def find_category
    @category = Category.find(params[:id])
  end
      
end
