module DiscussionsHelper

	# Checks if the user is the author of a discussion
	def discussion_author(discussion)
		logged_in? && current_user.id == discussion.user_id
	end

	# Checks if the user is the author of a reply
	def reply_author(reply)
		logged_in? && current_user.id == reply.user_id
	end

end
