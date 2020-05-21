class Topic < ApplicationRecord

	# Creating relationships for the model
	has_many :discussions
	# Essentially creating a join table between the two tables
	has_many :users, through: :discussions

end
