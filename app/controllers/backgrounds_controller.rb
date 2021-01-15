class BackgroundsController < ActionController::Base

  before_action :find_background, only: [:show, :update, :destroy, :edit]

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
        t.path = "/backgrounds/" + params[:background][:title] + File.extname(params[:background][:file].original_filename)
        #uploaded_io = params[:background][:data]
        #File.open(Rails.root.join('public', 'backgrounds', uploaded_io.original_filename), 'wb') do |file|
        #  file.write(uploaded_io.read)
        #end
      end

      #tags de imagen
      tags = ""
      #@categories = Category.all

      if params['categories']
        tags += params['categories']
      end

      if params['categories_2']
        if params['categories_2'] != "No"
          tags += "-" + params['categories_2']
        end
      end
      t.tags = tags
    end

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
    render json: {status:'SECCESS', message:'Background deleted', data:@background, status: :ok}
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