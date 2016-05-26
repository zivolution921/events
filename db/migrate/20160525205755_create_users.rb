class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      # encrypts the password
      # virtual attribute and not stored pass in database
      # uses salt to add different hash value
      t.string :password_digest

      t.timestamps
    end
  end
end
