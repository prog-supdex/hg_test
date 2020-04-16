class AddColumnErrorMessageToEvent < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :error_message, :text
  end
end
