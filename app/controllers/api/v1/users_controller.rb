module Api
  module V1
    class UsersController < ApplicationController

      require 'digest'
      before_action :find_user, only: [:show, :update, :destroy]

      def index
        render json:User.all
      end
      
      def show
        render json: @user
      end
      
      def create
        user = User.new(get_params)
        if user.save
          render json: {status:'SECCESS', message:'User saved', data:user, status: :ok}
        else
          render json: {status:'ERROR', message:'User not saved', data:user.errors, status: :unprocessable_entity}
        end
      end
      
      def update
        if @user.update(get_params)
          render json: {status:'SECCESS', message:'User update', data:user, status: :ok}
        else
          render json: {status:'ERROR', message:'User not updated', data:User.errors, status: :unprocessable_entity}
        end
      end
      
      def destroy
        @user.destroy
        render json: {status:'SECCESS', message:'User deleted', data:user, status: :ok}
      end
      
      def login
        user = User.find_by_email(params[:email])
        digestPasword =  Digest::SHA2.hexdigest params[:password]
        if user.password == digestPasword
          render json: {status: "SUCCESS", message: "User login", data:user}, status: :ok
        else
          render json: {status: 'ERROR', message:'user not valid'},status: :bad_request
        end
      end

      private
      def get_params
        params.required(:User).permit(:name, :email, :password)
      end
      
      def find_user
        @user = User.find(params[:id])
      end
    end
  end
end
