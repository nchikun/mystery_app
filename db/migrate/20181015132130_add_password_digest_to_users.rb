class AddPasswordDigestToUsers < ActiveRecord::Migration[5.1]
  # 既存テーブル(カラム)に何かしらの変更点を加える
  def change
    # usersテーブルのカラムにpassword_digestを追加するadd_columnメソッド
    add_column :users, :password_digest, :string
  end
end
