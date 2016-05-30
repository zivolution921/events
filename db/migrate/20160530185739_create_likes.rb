class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.references :event, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
