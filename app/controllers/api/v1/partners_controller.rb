# frozen_string_literal: true

module Api
  module V1
    class PartnersController < ApplicationController

      def index
        @group = User.all.includes(:partners)
        render json: @group.to_json(include: [:partners])
      end

      # パートナーの計画作成用のパートナー一覧検索
      def partner_index
        @user = User.find(params[:id])
        @partner_index = @user.partners.eager_load(:users)
        render json: @partner_index.to_json(include: [:users])
      end

      def search
        @group = Partner.eager_load(:users)
                        .where(['partner_group like ? OR name like ?', "%#{params[:id]}%", "%#{params[:id]}%"])
        @group_id = @group.map(&:id)
        @groups = Partner.where(id: @group_id).eager_load(:users).eager_load(:applies)
        render json: @groups.to_json(include: [:users, :applies])
      end

      def show
        @user = User.find(params[:id])
        @group = @user.partners.includes(:users)
        render json: @group.to_json(include: [:users])
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
