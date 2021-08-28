module Api
  module V1
    class PartnerApprovalsController < ApplicationController

      def index
      end

      def show
        @user = User.find(params[:id])
        @approval = @user.partner_approvals
        render json: @approval
      end

      def create
        @user = User.find(approval_params[:for_user])
        @approval = @user.partner_approvals.create!(approval_params)
      end

      def update
      end

      def destroy
      end

      private

      def approval_params
        params.permit(:comment, :partner_approval, :from_user, :for_user)
      end
    end
  end
end
