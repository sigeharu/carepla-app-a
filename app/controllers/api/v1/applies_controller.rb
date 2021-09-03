module Api
  module V1
    class AppliesController < ApplicationController

      def index
        @apply = Apply.where(for_user: params[:partner_id])
        render json: @apply
      end

      def applying
        @user = User.find(params[:id])
        @applying = @user.applies
      end

      def show
        @user = User.find(params[:id])
        @apply = @user.applies.find_by(partner_id: params[:partner_id])
        render json: @apply
      end

      def create
        @user = User.find(apply_params[:user_id])
        @user.applies.create(apply_params)
        @groups = @user.partners.eager_load(:users)
        @group_applies = @groups.eager_load(:applies)
        # render json: @group_applies.to_json(include: [:users, :applies])
      end

      def destroy
        @apply = Apply.find(params[:id])
        @apply.destroy!
      end

      private

      def apply_params
        params.require(:apply).permit(:user_id, :partner_id, :comment, :user_name, :for_user)
      end
    end
  end
end
