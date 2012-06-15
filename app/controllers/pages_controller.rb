class PagesController < ApplicationController
  def home
		if signed_in?
			@schedule = current_user.schedules.build
			@schedule_list_items = current_user.schedule_list
			@element = current_user.schedules[0].elements.build
		end
  end
end
