class CreateAppointments < ActiveRecord::Migration[6.1]
  def change
    create_table :appointments do |t|
      t.datetime :full_date
      t.string :notes_for_barber
      t.integer :user_id
      t.integer :barber_id      

      t.timestamps
    end
  end
end
