module Api
  module V1
    class GroupUsersController < ApplicationController

      def index
        @group_users = GroupUser.where(partner_id: params[:partner_id])
        render json: @group_users
      end

      def create
        @user = User.find(group_user_params[:user_id])
        @user.group_users.create(partner_id: group_user_params[:partner_id],
                                 user_id: group_user_params[:user_id],
                                 group_admin: true)
        Apply.find(group_user_params[:apply_id]).destroy!
      end

      def destroy
        @group_user = GroupUser.find(params[:id])
        @group_user.destroy!
      end

      private

      def group_user_params
        params.permit(:user_id, :partner_id, :apply_id)
      end
    end
  end
end