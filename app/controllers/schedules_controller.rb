class SchedulesController < ApplicationController
	before_filter :signed_in_user

	def create
		@schedule = current_user.schedules.build(params[:schedule])
		if @schedule.save
			flash[:success] = "Schedule added!"
			redirect_to root_path
		else
			render 'static_pages/home'
		end
	end

	def destroy
	end

end
