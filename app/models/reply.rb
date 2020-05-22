class Reply < ApplicationRecord

	# Creating relationships for the model
	# Discussion and User are reference to those tables through keys
	belongs_to :discussion
	belongs_to :user

	# Don't allow a reply to be submitted empty
	validates :reply, presence: true

end
