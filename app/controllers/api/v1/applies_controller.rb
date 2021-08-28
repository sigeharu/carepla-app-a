module Api
  module V1
    class AppliesController < ApplicationController

      def index
        @user = User.find(params[:partner_id])
        # @applies = @user.partners.eager_load(apply: :user)
        #                 .select(' partners.id,
        #                           partners.partner_group,
        #                           partners.admin_user,
        #                           applies.user_id,
        #                           applies.comment,
        #                           applies.users.name
        #                         ')
        # @applies = @user.partners.eager_load(applies: :user)
        @apply = Apply.where(for_user: params[:partner_id])
        @applies = @apply
        render json: @applies
      end

      def show
        @user = User.find(params[:id])
        @partner = Partner.find(params[:partner_id])
        @apply = @user.partners.includes(:group_users).includes(:applies)

        render json: @apply.to_json(include: %i[group_users applies users])
      end

      def create
        @user = User.find(apply_params[:user_id])
        @user.applies.create(apply_params)

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
