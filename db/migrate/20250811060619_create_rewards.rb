class CreateRewards < ActiveRecord::Migration[8.0]
  def change
    create_table :rewards do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.string :reward_type
      t.string :reason
      t.datetime :awarded_at

      t.timestamps
    end
    add_index :rewards, :reward_type
  end
end
