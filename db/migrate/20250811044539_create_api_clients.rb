class CreateApiClients < ActiveRecord::Migration[8.0]
  def change
    create_table :api_clients do |t|
      t.string :name, null: false
      t.string :api_key, null: false
      t.datetime :revoked_at
      t.timestamps
    end

    add_index :api_clients, :name, unique: true
    add_index :api_clients, :api_key, unique: true
    add_index :api_clients, :revoked_at
  end
end
