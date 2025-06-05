class AddCoordinatesToDesks < ActiveRecord::Migration[7.1]
  def change
    add_column :desks, :latitude,  :float
    add_column :desks, :longitude, :float
  end
end
