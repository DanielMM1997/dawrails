module Api
  module V1
    class TagsController < ApplicationController

      before_action :find_tag, only: [:show, :update, :destroy]

      def index
        render json:Tag.all
      end
      
      def show
        render json:@tag
      end
      
      def create
        tag = Tag.new(get_params)
        if tag.save
          render json: {status:'SECCESS', message:'Tag saved', data:user, status: :ok}
        else
          render json: {status:'ERROR', message:'Tag not saved', data:Tag.errors, status: :unprocessable_entity}
        end
      end
      
      def update
        if @tag.update(get_params)
          render json: {status:'SECCESS', message:'Tag updated', data:user, status: :ok}
        else
          render json: {status:'ERROR', message:'Tag not updated', data:Tag.errors, status: :unprocessable_entity}
        end
      end
      
      def destroy
        @tag.destroy
        render json: {status:'SECCESS', message:'Tag deleted', data:tag, status: :ok}
      end
      
      private
      def get_params
        params.required(:Tag).permit(:name)
      end
      
      def find_tag
        @tag = tag.find(params[:id])
      end
    end
  end
end
