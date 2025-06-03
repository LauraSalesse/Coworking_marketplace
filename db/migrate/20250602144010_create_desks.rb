class CreateDesks < ActiveRecord::Migration[7.1]
  def change
    create_table :desks do |t|
      t.text :description
      t.string :address
      t.string :location
      t.boolean :shared
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
