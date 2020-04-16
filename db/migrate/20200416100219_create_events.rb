class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :name, null: false
      t.string :event_type, null: false
      t.string :param1, null: false
      t.string :param2
      t.datetime :executed_at

      t.timestamps
    end
  end
end
