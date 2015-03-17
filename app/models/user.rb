# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ActiveRecord::Base
  include Commentable

  attr_reader :password
  validates :username, :password_digest, :session_token, presence: true
  validates :username, :session_token, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true }

  has_many :goals, dependent: :destroy
  has_many :authored_comments, class_name: 'Comment', foreign_key: :author_id

  after_initialize :ensure_session_token

  def self.find_by_credentials(username, password)
    user = User.find_by_username(username)
    return nil if user.nil? || !user.is_password?(password)
    user
  end

  def self.generate_session_token
    token = SecureRandom.urlsafe_base64(16)
    while User.exists?(session_token: token)
      token = SecureRandom.urlsafe_base64(16)
    end
    token
  end

  def reset_session_token!
    self.session_token = User.generate_session_token
    save!
    self.session_token
  end

  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end

  def is_password?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

end
