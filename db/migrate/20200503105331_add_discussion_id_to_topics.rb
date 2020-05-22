class AddDiscussionIdToTopics < ActiveRecord::Migration[5.2]
  def change
    add_column :topics, :discussion_id, :integer
  end
end
