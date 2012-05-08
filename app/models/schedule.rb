class Schedule < ActiveRecord::Base
	belongs_to :user
	validates :user_id, presence: true

	default_scope order: 'schedules.created_at ASC'
end
