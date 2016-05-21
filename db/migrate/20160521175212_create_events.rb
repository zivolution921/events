class CreateEvents < ActiveRecord::Migration
  def change
    # how to change database schema
    create_table :events do |t|
      t.string :name
      t.string :location
      t.decimal :price

      t.timestamps null: false
    end
  end
end
