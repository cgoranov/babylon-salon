class CreateBarbers < ActiveRecord::Migration[6.1]
  def change
    create_table :barbers do |t|
      t.string :first_name
      t.string :last_name
      t.integer :chair
      t.integer :cut_duration_seconds
      t.timestamps
    end
  end
end
