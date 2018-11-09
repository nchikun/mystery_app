# modelsにはDBの規則を書く
# usersテーブルの中の1つのレコードについての規則なので単数形

class User < ApplicationRecord

  # アクセスを認めるカラム
  attr_accessor :remember_token

  # emailのフォーマットは以下の正規表現を満たす
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  # DB保存する前に実行する処理（emailは必ず小文字で保存して一意性を保つ）
  before_save { self.email = email.downcase }

  # 空白(nil)制限,文字長制限,(emailはフォーマット制限,一意制限)
  validates :name,  presence: true, length: { maximum: 50  }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  # passwordハッシュ化（create時のみ）
  has_secure_password

  # passwordに関して,入力があること,6文字以上の文字列であること,nilを許す（PATCH）
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  class << self

    # ユーザ入力のパスワードのハッシュ値を返す
    def digest(input_pass)
      # costが高ければ安全なハッシュ値を返す
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                    BCrypt::Engine.cost
      # ハッシュ化パスワードの生成
      BCrypt::Password.create(input_pass, cost: cost)
    end

    # ログイン時のトークン生成
    def new_token
      # SecureRandomクラスのurlsafe_base64メソッドで64種類のランダムな22文字を生成
      SecureRandom.urlsafe_base64
    end

  end

  # ログイン時の生成トークンをダイジェストにハッシュ化
  def remember
    # remember_tokenはログイン状態のときには持っている必要があるためself.(DB保存はしない)
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # ユーザ承認のためにユーザが持つトークンとダイジェストを比較して一致したら有効化
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # 永続化からログアウト状態にする
  def forget
    # カラム変更update_attribute([変更Key],[変更後Value])
    update_attribute(:remember_digest, nil)
  end

end
