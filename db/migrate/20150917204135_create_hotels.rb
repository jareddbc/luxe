class CreateHotels < ActiveRecord::Migration
  def change
    create_table :hotels do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :address
      t.text :amenities
      t.boolean :terms, default: false

      t.timestamps null: false
    end
  end
end
