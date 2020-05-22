class AddDataCreatedToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :date_created, :datetime
  end
end
