class ElementsController < ApplicationController
	before_filter :signed_in_user, only: [:create, :destroy]

	def create
		@element = current_user.schedules[0].elements.build(params[:element])
		if @element.save
			flash[:success] = "Element added to schedule!"
			redirect_to root_path
		end
	end

	def destroy
	end

end
