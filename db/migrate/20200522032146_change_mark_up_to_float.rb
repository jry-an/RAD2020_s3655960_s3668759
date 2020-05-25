class ChangeMarkUpToFloat < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :mobile_number, :float
  end
end
