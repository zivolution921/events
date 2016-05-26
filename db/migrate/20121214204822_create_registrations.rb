class CreateRegistrations < ActiveRecord::Migration
  def change
    create_table :registrations do |t|
      t.string :name
      t.string :email
      t.string :how_heard
      #registrations reference to event
      t.references :event, index: true

      t.timestamps
    end
  end
end
