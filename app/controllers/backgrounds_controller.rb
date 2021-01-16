class BackgroundsController < ActionController::Base
  include ApplicationHelper

  before_action :find_background, only: [:show, :update, :destroy, :edit]
  skip_before_action :verify_authenticity_token, only:[:search]

  def index
    render json:Background.all
  end
  
  def show
    @categories = Category.all
    @category = @background.categories.first
    @backgrounds = @category.backgrounds
    @num_likes = Like.where(background_id: @background.id).count()
    if @num_likes == nil
      @num_likes = 0
    end
    if logged_in?
      @user_like = @background.likes.where(user_id: current_user.id, background_id: params[:id]).count()
    end
    render layout:"application"
    #render json: {status:'SECCESS', message:'Category updated', data:@backgrounds, status: :ok}
  end

  def new
    @background = Background.new
    @categories = Category.all
    render layout:"form"
  end

  def edit
    render layout:"form"
  end
    
  def create
    background = Background.new(get_params)
    if background.save
      render json: {status:'SECCESS', message:'Background saved', data:background, status: :ok}
    else
      render json: {status:'ERROR', message:'Background not saved', data:background.errors, status: :unprocessable_entity}
    end
  end
  
  def create_user_background
    background = Background.new() do |t|
      t.title = params[:background][:title]
      t.author_id = params[:background][:author_id]
      #path de imagen
      if params[:background][:file]
        @filename = params[:background][:title] + File.extname(params[:background][:file].original_filename)
        t.path = "/backgrounds/" + @filename
      end

      #tags de imagen
      tags = ""
      #@categories = Category.all
      #@category1 = ""
      #@category2 = ""

      if params['categories']
        tags += params['categories']
        @category1 = Category.where('name LIKE ?', "%#{params[:categories]}%").first
      end

      if params['categories_2']
        if params['categories_2'] != "No"
          tags += "-" + params['categories_2']
          @category2 = Category.where('name LIKE ?', "%#{params[:categories_2]}%").first
        end
      end
      t.tags = tags
    end

    if background.save
      uploaded_io = params[:background][:file]
      File.open(Rails.root.join('public', 'backgrounds', @filename), 'wb') do |file|
        file.write(uploaded_io.read)
      end
      BackgroundCategory.create([{ :background_id => background.id, :category_id => @category1.id }])
      if params['categories_2'] != "No"
        BackgroundCategory.create([{ :background_id => background.id, :category_id => @category2.id }])
      end
      flash[:success] = '¡Se ha subido el fondo de pantalla correctamente!'
      redirect_to user_path(current_user.id)
      #render json: {status:'SECCESS', message:'Background saved', data:background, status: :ok}
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
    render json: {status:'SECCESS', message:'Background deleted', data:@background, status: :ok}
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
    @search = params[:query]
    @categories = Category.all
    @backgrounds = Background.where('title LIKE ?', "%#{params[:query]}%")
    render layout:"application"
  end
  
  def like
    if logged_in?
      Like.create([{ :background_id => params[:id], :user_id => current_user.id }])
      @num_likes = Like.where(background_id: params[:id]).count()
      if @num_likes == nil
        @num_likes = 0
      end
      redirect_to background_url(params[:id])
    else
      redirect_to login_path
    end
  end
  
  def dislike
    aux = Like.where(user_id: current_user.id, background_id: params[:id])
    aux[0].delete
    @num_likes = Like.where(background_id: params[:id]).count()
    if @num_likes == nil
      @num_likes = 0
    end
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