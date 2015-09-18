class CreateGuests < ActiveRecord::Migration
  def change
    create_table :guests do |t|
      t.string :key
      t.references :hotel, index: true, foreign_key: true
      t.integer :room_number

      t.timestamps null: false
    end
  end
end
