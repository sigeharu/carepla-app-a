# frozen_string_literal: true

module Api
  module V1
    class DiariesController < ApplicationController
      def index

        diaries = Diary.order('created_at DESC')
        render json: diaries
      end

      def show
        diary = Diary.find(params[:id])
        render json: diary
      end

      def create
        diary = Diary.new(diary_params)
        if diary.save
          render json: diary
        else
          render json: { status: 401, errors: '送信できませんでした!再度入力してください!' }
        end
      end

      def update
        diary = Diary.find(params[:id])
        if diary.update(diary_params)
          render json: diary
        else
          render json: { status: 401, errors: '送信できませんでした!再度入力してください!' }
        end
      end

      def destroy
        diary = Diary.find(params[:id])
        diary.destroy
        render json: diary
      end

      private

      def set_user
        @user = User.find(params[:id])
      end

      def diary_params
        params.require(:diary).permit(:comment, :user_id)
      end
    end
  end
end
