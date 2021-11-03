class RemoveLastNameFromBarbers < ActiveRecord::Migration[6.1]
  def change
    remove_column :barbers, :last_name, :string
    add_column :barbers, :chair, :integer
    add_column :barbers, :duration_minutes, :integer
  end
end
