class SchedulesController < ApplicationController
	before_filter :signed_in_user, only: [:create, :destroy]
	before_filter :correct_user, only: :destroy

	def create
		@schedule = current_user.schedules.build(params[:schedule])
		if @schedule.save
			flash[:success] = "Schedule added!"
			redirect_to root_path
		else
			@schedule_list_items = []
			render 'static_pages/home'
		end
	end

	def destroy
		@schedule.destroy
		redirect_back_or root_path
	end

	private

		def correct_user
			@schedule = current_user.schedules.find_by_id(params[:id])
			redirect_to root_path if @schedule.nil?
		end
end
