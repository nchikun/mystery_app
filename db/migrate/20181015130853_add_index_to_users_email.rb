class AddIndexToUsersEmail < ActiveRecord::Migration[5.1]
  # 既存テーブル(カラム)に何かしらの変更点を加える
  def change
    # usersテーブルのemailにインデックスを加えて一意性を強制するadd_indexメソッド
    add_index :users, :email, unique: true
  end
end
