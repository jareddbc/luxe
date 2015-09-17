class CreateVisitors < ActiveRecord::Migration
  def change
    create_table :visitors do |t|
      t.string :key
      t.references :hotel, index: true, foreign_key: true
      t.integer :room_number

      t.timestamps null: false
    end
  end
end
