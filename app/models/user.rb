class User < ApplicationRecord
  # これ、右の方selfいらんのか？→Userクラスの中だからいいらしい
  # before_save { self.email = email.downcase }
  before_save { email.downcase! }

  # self.validates(:name, presence: true)
  validates :name, presence: true, length: { maximum: 50 }

  # /\A \z/ はRailsルール？
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    # upcaseとdowncaseを区別しない
                    # uniquenessは暗黙的にtrue
                    uniqueness: { case_sensitive: false }

  # ハッシュ化したパスワードをpassword_digestに保存(要password_digest)
  # authenticateがつかえる　passwordとpassword_confirmationがつかえる
  has_secure_password

  validates :password, presence: true, length: { minimum: 6 }

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end
