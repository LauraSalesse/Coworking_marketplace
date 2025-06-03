class AddTitleAndPriceToDesks < ActiveRecord::Migration[7.1]
  def change
    add_column :desks, :title, :string
    add_column :desks, :price, :integer
  end
end
