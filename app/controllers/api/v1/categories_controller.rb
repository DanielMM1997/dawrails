module Api
  module V1
    class CategoriesController < ApplicationController

      before_action :find_category, only: [:show, :update, :destroy]

      def index
        render json:Category.all
      end
      
      def show
        render json:@category
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
        render json: {status:'SECCESS', message:'Category deleted', data:category, status: :ok}
      end
      
      private
      def get_params
        params.required(:Category).permit(:name)
      end
      
      def find_category
        @category = Category.find(params[:id])
      end
    end
  end
end
