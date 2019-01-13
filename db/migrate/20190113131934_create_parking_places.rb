class CreateParkingPlaces < ActiveRecord::Migration[5.2]
  def change
    create_table :parking_places do |t|
      t.string :name

      t.timestamps
    end
  end
end
