class CreateRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :relationships do |t|
      
      # 下２行は外部キーを作成し、Usersテーブルのidのみを参照するよう固定している
      # 自身がフォローしている人
      t.references :follower, foreign_key: { to_table: :users }
      # 自身をフォローしている人
      t.references :followed, foreign_key: { to_table: :users }

      t.timestamps
    end
    
    # 下記のカラムの組み合わせは重複しない
    add_index :relationships, [:follower_id, :followed_id], unique: true
  end
end
