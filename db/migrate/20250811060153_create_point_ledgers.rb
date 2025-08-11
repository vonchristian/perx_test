class CreatePointLedgers < ActiveRecord::Migration[8.0]
  def change
    create_table :point_ledgers do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :purchase, null: false, foreign_key: true
      t.integer :points, null: false
      t.string :reason, null: false

      t.timestamps
    end
  end
end
