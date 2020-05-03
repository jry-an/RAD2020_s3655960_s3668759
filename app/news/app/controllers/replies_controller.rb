class RepliesController < ApplicationController

	# Check the user is logged in
	before_action :authenticate_user!
	# Find the reply for each of the views (edit, update, show, destroy)
	before_action :set_reply, only: [:edit, :update, :show, :destroy]
	# Find the discussion for each of the views (create, edit, show, update, destroy)
	before_action :set_discussion, only: [:create, :edit, :show, :update, :destroy]

	# method for creating a new reply
	def create
		# Creates a reply within a discussion 
		@reply = @discussion.replies.create(params[:reply]).permit(:reply, :discussion_id)
		# Sets the reply user id to the current user
		# Show that we can show what user wrote that reply
		@reply.user_id = current_user.id

		respond_to do |layout|
			if @reply.save 
				# If the reply has saved, redirect to the discussion
				layout.html { redirect_to discussion_path(@discussion) }
				# Allows us to load a new reply without having to refresh the whole page
				layout.js # render create.js.erb
			else
				# If the reply did not save, show error message
				layout.html { redirection_to discussion_path(@discussion), 
					notice: 'Error: Reply did not enter.  Please try again'}
				# Allows us to load a new reply without having to refresh the whole page
				layout.js # render create.js.erb
			end
		end
	end

	def new
	end

	# method for deleting a posted reply
	def destroy
		# Find a reply that matches the id
		@reply = @discussion.replies.find(params[:id])
		# Delete the matching reply
		@reply.destroy
		# Redirect to the discussion 
		redirect_to discussion_path(@discussion)
	end

	# method for editing a reply
	def edit
		# Get the discussion that matches the discussion id
		# Essentially find the discussion that has the reply we want to edit
		@discussion = Discussion.find(params[:discussion_id])
		# Get the reply from the found discussion that we want to edit
		@reply = @discussion.replies.find(params[:id])
	end

	# method for updating a reply
	def update
		# Find the reply
		@reply = @discussion.replies.find(params[:id])

		respond_to do |layout|
			if @reply.update(reply_params)
				# If the reply was successfully updated, display a notice to 
				# the user and go to the discussion
				layout.html { redirect_to discussion_path(@discussion), 
					notice: 'Reply was added.'}
			else 
				# If the reply wasn't added, redirect to the edit page
				layout.html { render :edit }
				format.json { redner json: @reply.errors, status: :unprocessable_entity }
			end
		end
	end

	private

	def set_discussion
		# Get discussions that match the discussion id param
		@discussion = Discussion.find(params[:discussion_id])
	end

	def set_reply
		# Get replies that match the reply id
		@reply = Reply.find(params[:id])
	end

	def reply_params
		params.require(:reply).permit(:reply)
	end
end
