class User < ApplicationRecord
  has_many :flowers, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  #userがお気に入りした花の情報を取得できる
  has_many :favorite_flowers, through: :favorites, source: :flower, dependent: :destroy
  
  has_one_attached :profile_image

  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable
  
  validates :name, presence: true, length: { maximum: 300 }
  validates :email, presence: true, length: { maximum: 300 }
  validates :password, length: { minimum: 6, maximum: 300 }, if: :password_required?, allow_blank: true
  validates :password_confirmation, presence: true, if: :password_required?

  private

  # パスワードが必要かどうかを判断。新規ユーザーまたはパスワード変更を試みる既存ユーザーに対して必要かどうか
  def password_required?
    !persisted? || password.present? || password_confirmation.present?
  end

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = user.password_confirmation = SecureRandom.urlsafe_base64
      user.confirmed_at = Time.now  # Confirmable を使用している場合は必要
      user.name = "ゲスト"
    end
  end

  def self.guest_admin
    find_or_create_by!(email: 'guest_admin@example.com') do |user|
      user.password = user.password_confirmation = SecureRandom.urlsafe_base64
      user.confirmed_at = Time.now  # Confirmable を使用している場合は必要
      user.name = 'ゲスト管理者' # ここで名前を設定
      user.admin = true
    end
  end
end
