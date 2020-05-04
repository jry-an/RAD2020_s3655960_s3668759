module DiscussionsHelper

	# Checks if the user is the author of a discussion
	def discussion_author(discussion)
		user_signed_in? && current_user.id == discussion.user_id
	end

	# Checks if the user is the author of a reply
	def reply_author(reply)
		user_signed_in? && current_user.id == reply.user_id
	end

end
