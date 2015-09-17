class CreateHotels < ActiveRecord::Migration
  def change
    create_table :hotels do |t|
      t.string :name
      t.string :email
      t.string :password_hash
      t.string :password_salt
      t.text :amenities
      t.string :location

      t.timestamps null: false
    end
  end
end
