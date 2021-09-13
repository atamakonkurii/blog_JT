class DropActiveStorageAttachments < ActiveRecord::Migration[6.1]
  def change
    drop_table :active_storage_variant_records
  end
end
