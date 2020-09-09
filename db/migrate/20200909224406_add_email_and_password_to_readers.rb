class AddEmailAndPasswordToReaders < ActiveRecord::Migration[6.0]
  def change
    add_column :readers, :email, :string
    add_column :readers, :password_digest, :string
  end
end
