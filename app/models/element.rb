class Element < ActiveRecord::Base
  attr_accessible :schedule_id
	validates :schedule_id, presence: true
end
