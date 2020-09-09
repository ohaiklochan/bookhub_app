class AddBookidAndReaderidToReviews < ActiveRecord::Migration[6.0]
  def change
    add_reference :reviews, :reader, null: false, foreign_key: true
    add_reference :reviews, :book, null: false, foreign_key: true
  end
end
