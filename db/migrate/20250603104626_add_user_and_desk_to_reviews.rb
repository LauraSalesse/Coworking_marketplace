class AddUserAndDeskToReviews < ActiveRecord::Migration[7.1]
  def change
    add_reference :reviews, :user, null: false, foreign_key: true
    add_reference :reviews, :desk, null: false, foreign_key: true
  end
end
