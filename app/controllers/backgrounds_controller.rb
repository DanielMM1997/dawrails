class BackgroundsController < ActionController::Base
  include ApplicationHelper

  before_action :find_background, only: [:show, :update, :destroy,]
  def index
    render json:Background.all
  end
  
  def show
    @categories = Category.all
    @category = @background.categories.first
    @backgrounds = @category.backgrounds
    @num_like = @background.likes.where(user_id: current_user.id, background_id: params[:id]).count()
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
    backgrounds = Background.all.order('created_at DESC').limit('6')
    render json: {status:'SECCESS', message:'SECCESS', data:backgrounds, status: :ok}
  end

  def allRecientes
    backgrounds = Background.all.order('created_at DESC')
    render json: {status:'SECCESS', message:'SECCESS', data:backgrounds, status: :ok}
  end

  def destacados
    backgrounds = Background.all.order('created_at ASC').limit('6')
    render json: {status:'SECCESS', message:'SECCESS', data:backgrounds, status: :ok}
  end

  def allDestacados
    backgrounds = Background.all.order('created_at ASC')
    render json: {status:'SECCESS', message:'SECCESS', data:backgrounds, status: :ok}
  end

  def search
    @category = @background.categories.first
    @backgrounds = @category.backgrounds
    render json:@backgrounds.where('category LIKE ? AND title', "%#{params[:query]}%")
  end
  
  def like
    Like.create([{ :background_id => params[:id], :user_id => current_user.id }])
    redirect_to background_path(params[:id])
  end
  
  def dislike
    aux = Like.where(user_id: current_user.id, background_id: params[:id])
    aux[0].delete
    redirect_to background_path(params[:id])
  end

  private
  def get_params
    params.required(:background).permit(:title, :url, :tags, :categories)
  end

  def find_background
    @background = Background.find(params[:id])
  end
      
end