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

      def search
        @groups = Partner.eager_load(:users)
                         .where(['partner_group like ? OR name like ?', "%#{params[:id]}%", "%#{params[:id]}%"])

        # @search = @groups.map do |group|
        #   {
        #     id: group.id,
        #     partner_group: group.partner_group,
        #     partner_group_description: group.partner_group_description,
        #     admin_user: group.admin_user,
        #     recruit_partner: group.recruit_partner,
        #     created_at: group.created_at,
        #     updated_at: group.updated_at,
        #     users:
        #       group.users.map do |user|
        #         {
        #           id: user.id,
        #           uid: user.uid,
        #           provider: user.provider,
        #           email: user.email,
        #           name: user.name,
        #           nickname: user.nickname,
        #           image: user.image,
        #           allowPasswordChange: user.allow_password_change,
        #           created_at: user.created_at,
        #           updated_at: user.updated_at
        #         }
        #       end
        #   }
        # end
        render json: @groups.to_json(include: [:users])
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

      def self.search(keyword)
        where(['partner_group like ? OR name like ?', "%#{keyword}%", "%#{keyword}%"])
      end

      def set_user
        @user = User.find(params[:id])
      end

      def search_params
        params.permit(:keyword)
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
