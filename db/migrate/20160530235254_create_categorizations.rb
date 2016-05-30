class CreateCategorizations < ActiveRecord::Migration
  def change
    create_table :categorizations do |t|
      t.string :event
      t.string :references
      t.references :category, index: true

      t.timestamps
    end
  end
end
