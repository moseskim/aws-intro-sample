class User < ApplicationRecord
  has_many :microposts, dependent: :destroy
  has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "follower_id",
                                  dependent:   :destroy
  has_many :passive_relationships, class_name:  "Relationship",
                                   foreign_key: "followed_id",
                                   dependent:   :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  attr_accessor :remember_token, :activation_token, :reset_token
  before_save   :downcase_email
  before_create :create_activation_digest
  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  # 전달된 문자열의 해시값을 반환한다
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # 무작위 토큰을 반환한다
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # 역구 세션을 위해 사용자를 데이터베이스에 기록한다
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # 토큰이 다이제스트와 일치하면 true를 반환한다
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  # 사용자의 로그인 정보를 파기한다
  def forget
    update_attribute(:remember_digest, nil)
  end

  # 계정을 활성화한다
  def activate
    update_attribute(:activated,    true)
    update_attribute(:activated_at, Time.zone.now)
  end

  # 활성화용 메일을 송신한다
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  # 비밀번호 재설정 속성을 설정한다
  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest,  User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  # 비밀번호 재설정 메일을 송신한다
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  # 비밀번호 재설정 기한이 만료되었다면 true를 반환한다
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  # 사용자의 상태 피드를 반환한다
  def feed
    following_ids = "SELECT followed_id FROM relationships
                     WHERE follower_id = :user_id"
    Micropost.where("user_id IN (#{following_ids})
                     OR user_id = :user_id", user_id: id)
  end

  # 사용자를 팔로우한다
  def follow(other_user)
    following << other_user
  end

  # 사용자를 언팔로우한다
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  # 현재 사용자가 팔로우했다면 true를 반환한다
  def following?(other_user)
    following.include?(other_user)
  end

  private

    # 이메일 주소를 모두 소문자로 바꾼다
    def downcase_email
      self.email = email.downcase
    end

    # 활성화 토큰과 다이제스트를 생성하고 대입한다
    def create_activation_digest
      self.activation_token  = User.new_token
      self.activation_digest = User.digest(activation_token)
    end
end
