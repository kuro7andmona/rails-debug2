class CreateRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :relationships do |t|
      t.integer :follower_id, foreign_key: { to_table: :users }
      t.integer :followed_id, forign_key: { to_table: :users }
      t.timestamps

      t.index [:follower_id, :followed_id], unique: true
    end
  end
end
