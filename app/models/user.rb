class User < ActiveRecord::Base
  validates :email, :password_digest, :session_token, presence: true, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true }

  after_initialize :ensure_session_token
  attr_reader :password

  def self.generate_session_token
    SecureRandom::urlsafe_base64(32)
  end

  def reset_session_token!
    self.session_token = self.class.generate_session_token
    self.save
    self.session_token
  end

  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end

  def password=(pw)
    @password = pw
    pw_digest = BCrypt::Password.create(pw)
    self.password_digest = pw_digest
  end

  def is_password?(pw)
    password_digest = BCrypt::Password.new(self.password_digest)
    password_digest.is_password?(pw)
  end

  def self.find_by_credentials(email, password)
    potential_user = User.find_by(email: email)
    return nil unless potential_user

    potential_user.is_password?(password) ? potential_user : nil
  end

end
