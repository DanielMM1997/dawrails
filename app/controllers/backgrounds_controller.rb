class BackgroundsController < ActionController::Base

  before_action :find_background, only: [:show, :update, :destroy]

  def index
    render json:Background.all
  end
  
  def show
    @categories = Category.all
    @category = @background.categories.first
    @backgrounds = @category.backgrounds
    render layout:"application"
    #render json: {status:'SECCESS', message:'Category updated', data:@backgrounds, status: :ok}
  end
    
  def create
    background = Background.new(get_params)
    if background.save
      render json: {status:'SECCESS', message:'Background saved', data:background, status: :ok}
    else
      render json: {status:'ERROR', message:'Background not saved', data:background.errors, status: :unprocessable_entity}
    end
  end
  
  def update
    if @background.update(get_params)
      render json: {status:'SECCESS', message:'Background updated', data:background, status: :ok}
    else
      render json: {status:'ERROR', message:'Background not updated', data:background.errors, status: :unprocessable_entity}
    end
  end
      
  def destroy
    @background.destroy
    render json: {status:'SECCESS', message:'Background deleted', data:background, status: :ok}
  end

  def recientes
    render json: Background.all.order('created_at DESC').limit('6')
  end

  def destacados
    backgrounds = Background.all.order('created_at DESC').limit('6')
    # backgrounds = Like.find(@background).count()
    render json: {status:'SECCESS', message:'SECCESS', data:backgrounds, status: :ok}
  end

  private
  def get_params
    params.required(:background).permit(:title, :url, :tags, :categories)
  end

  def find_background
    @background = Background.find(params[:id])
  end
      
end