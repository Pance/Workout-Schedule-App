class PagesController < ApplicationController
  def home
		if signed_in?
			@schedule = current_user.schedules.build if signed_in?
			@schedule_list_items = current_user.schedule_list
		end
  end
end
