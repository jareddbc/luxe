class CreateHotels < ActiveRecord::Migration
  def change
    create_table :hotels do |t|
      t.string :name
      t.text :amenities
      t.string :location

      t.timestamps null: false
    end
  end
end
