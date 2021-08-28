# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController

      def index
        @users = User.where(id: from_user_params)
        render json: @users
      end

      def show
        @user = User.find(params[:id])
        render json: @user
      end

      def create

      end

      def update

      end

      def destroy

      end

      private

      def from_user_params
        params.permit(from_user: [])
      end
    end
  end
end