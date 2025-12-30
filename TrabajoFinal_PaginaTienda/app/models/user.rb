class User < ApplicationRecord
  belongs_to :role

  has_secure_password

  validates :name, presence: true, length: { maximum: 100 }
  validates :username, presence: true, uniqueness: true, length: { maximum: 50 }
  validates :mail, presence: true, uniqueness: true, length: { maximum: 255 }
  validates :phone, presence: true
  validates :entrydate, presence: true

  def password_required?
    new_record? || password.present? || password_digest_changed?
  end

  def self.authenticate(login, password)
    user = User.find_by("username = ? OR mail = ?", login, login)
    user && user.authenticate(password) ? user : nil
  end

end
