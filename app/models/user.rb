class User < ApplicationRecord
  # 仮想の属性（カラム）
  attr_accessor :remember_token

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

  # # fixtureで使ってる
  # def User.digest(string)
  #   cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
  #   BCrypt::Password.create(string, cost: cost)
  # end

  # def User.new_token
  #   SecureRandom.urlsafe_base64
  # end

  class << self
    def digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?
    # remember_digestはDBに含まれる→ActiveRecordに紐付いてるので、selfで呼べてる
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end
end
