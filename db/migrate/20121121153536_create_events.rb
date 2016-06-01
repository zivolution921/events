class CreateEvents < ActiveRecord::Migration
  def change
    # name of table is events and ruby block to define columns on the database table
    # instructions to modify database schema
    create_table :events do |t|
      t.string :name
      t.string :location
      t.decimal :price

      t.timestamps
    end
  end
end
