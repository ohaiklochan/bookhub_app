class AddAdminUidAndProviderToReaders < ActiveRecord::Migration[6.0]
  def change
    add_column :readers, :admin, :boolean
    add_column :readers, :uid, :string
    add_column :readers, :provider, :string
  end
end
