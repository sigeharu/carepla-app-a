# frozen_string_literal: true

module Api
  module V1
    class PartnersController < ApplicationController

      def index
        group_users = []
        @group = User.all.includes(:partners)
        # @partners.users.each do |group_user|
        #   group_users << group_user.user.name
        # end
        render json: @group.to_json(include: [:partners])
      end

      def show
        @user = User.find(params[:id])
        @group = @user.partners.includes(:users)

        render json: @group.to_json(include: [:users])
        # @user = User.find(params[:id])
        # @group = @user.partners.joins(:users)
        #               .select('partners.id,
        #                          partners.partner_group,
        #                          partner_group_description,
        #                          partners.admin_user,
        #                          partners.created_at,
        #                          partners.updated_at,
        #                          users.id AS user_id,
        #                          users.name
        #                         ')
        # render json: @group
      end

      def create
        @user = User.find(params[:admin_user])
        if @partner = @user.partners.create!(partner_params)
          # @group = Partner.joins(:users).where(id: @partner.id)
          #                 .select('partners.id,
          #                        partners.partner_group,
          #                        partner_group_description,
          #                        partners.admin_user,
          #                        partners.created_at,
          #                        partners.updated_at,
          #                        users.id AS user_id,
          #                        users.name
          #                       ')
          @group = @user.partners.includes(:users).last
          render json: @group.to_json(include: [:users])
        else
          render json: { status: 401, errors: '送信できませんでした!再度入力してください!' }
        end
      end

      def join
        @user = User.find(join_params)
        @partner = Partner.find(params[:id])
        @partner.users << @user
        if @partner.save
          @group = @user.partners.includes(:users).last
          render json: @group.to_json(include: [:users])
        else
          render json: { status: 401, errors: '送信できませんでした｡'}
        end
      end

      def update
        @partner = Partner.find(params[:id])
        if @partner.update!(partner_params)
          @user = User.find(params[:admin_user])
          @group = @user.partners.includes(:users).find_by(id: @partner.id)
          render json: @group.to_json(include: [:users])
        else
          render json: { status: 401, errors: '送信できませんでした!再度入力してください!' }
        end
      end

      def destroy
        @partner = Partner.find(params[:id])
        @partner.destroy
      end

      private

      def set_user
        @user = User.find(params[:id])
      end

      def join_params
        params.require(:user).permit(:id)
      end

      def partner_params
        params.require(:partner).permit(:partner_group, :partner_group_description, :admin_user)
      end
    end
  end
end
