class AddAddressToAddresses < ActiveRecord::Migration[6.0]
  def change
    add_column :addresses, :address, :string, null: false
  end
end
