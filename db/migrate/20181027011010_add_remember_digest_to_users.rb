# マイグレーションクラス
# rails db:migrate実行でメソッドに記載されたmigrationを実行する

class AddRememberDigestToUsers < ActiveRecord::Migration[5.1]
  def change
    # usersテーブルにstring型のremember_digestカラムを追加
    add_column :users, :remember_digest, :string
  end
end
