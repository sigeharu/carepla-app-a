# frozen_string_literal: true

module Api
  module V1
    class PartnersController < ApplicationController

      def index
        @partners = Partner.find(params[:partner_id])
        if @partner.users.where(id: current_user)
          @partners.group_users.each do |group_user|
            group_user.user.name
          end
        end
        render json: partners
      end

      def show
        partner = Partner.find(params[:id])
        render json: partner
      end

      def create
        @partner = Partner.new(partner_params)
        if @partner.save
          render json: partner
        else
          render json: { status: 401, errors: '送信できませんでした!再度入力してください!' }
        end
      end

      def update
        partner = partner.find(params[:id])
        if partner.update(partner_params)
          render json: partner
        else
          render json: { status: 401, errors: '送信できませんでした!再度入力してください!' }
        end
      end

      def destroy
        partner = partner.find(params[:id])
        partner.destroy
        render json: partner
      end

      private

      def set_user
        @user = User.find(params[:id])
      end

      def partner_params
        params.require(:partner).permit(:partner_group, :partner_group_description, :admin_user)
      end
    end
  end
end
