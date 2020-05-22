class AddViewCountToDiscussion < ActiveRecord::Migration[5.2]
  def change
    add_column :discussions, :view_count, :integer, :default => 0
  end
end
