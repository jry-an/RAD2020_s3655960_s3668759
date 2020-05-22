class AddLastSeenAtToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :last_seen_at, :datetime, :default => DateTime.now
    change_column  :users, :last_seen_at, :datetime, :default => DateTime.now
  end
end
