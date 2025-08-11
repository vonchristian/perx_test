class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.date :birth_date
      t.string :country
      t.datetime :first_purchase_at

      t.timestamps
    end

    add_index :users, :email, unique: true
  end
end
