module Api
  module V1
    class BackgroundsController < ApplicationController

      before_action :find_background, only: [:show, :update, :destroy]

      def index
        render json:Background.all
      end
      
      def show
        render json: @background
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

      
      private
      def get_params
        params.required(:background).permit(:title, :url, :tags, :categories)
      end

      def find_background
        @background = Background.find(params[:id])
      end
      
    end
  end
end
