class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.references :hotel, index: true, foreign_key: true
      t.datetime :starts_at_date
      t.datetime :starts_at_time
      t.string :title
      t.text :special_request
      t.boolean :completed

      t.timestamps null: false
    end
  end
end
