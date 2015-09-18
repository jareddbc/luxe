class CreateGuests < ActiveRecord::Migration
  def change
    create_table :guests do |t|
      t.string :key
      t.references :hotel, index: true, foreign_key: true
      t.string :first_name
      t.string :last_name
      t.integer :room_number
      t.string :phone


      t.timestamps null: false
    end
  end
end
