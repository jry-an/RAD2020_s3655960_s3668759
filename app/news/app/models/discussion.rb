# frozen_string_literal: true
class Discussion < ApplicationRecord

	# Creating relationships for the model
	# Topic and User references those tables
	belongs_to :topic
	belongs_to :user
	has_many :replies, dependent: :destroy

	# Don't allow the title or content to be submitted empty
	validates :title, :content, presence: true

	def increment(by =1 )
		self.view_count ||= 0
		self.view_count += by
		save
	end

end
