# frozen_string_literal: true

module Api
  module V1
    class SchedulesController < ApplicationController

      def index
        schedules = Schedule.order('created_at DESC')
        render json: schedules
      end

      def show
        schedule = Schedule.find(params[:id])
        render json: schedule
      end

      def create
        schedule = Schedule.new(schedule_params)
        if schedule.save
          render json: schedule
        else
          render json: { status: 401, errors: '送信できませんでした!再度入力してください!' }
        end
      end

      def update
        schedule = Schedule.find(params[:id])
        if schedule.update(schedule_params)
          render json: schedule
        else
          render json: { status: 401, errors: '送信できませんでした!再度入力してください!' }
        end
      end

      def destroy
        schedule = Schedule.find(params[:id])
        schedule.destroy
        render json: schedule
      end

      private

      def set_user
        @user = User.find(params[:id])
      end

      def schedule_params
        params.require(:schedule).permit(:title, :schedule_date, :completion, :takeover, :user_id)
      end
    end
  end
end
