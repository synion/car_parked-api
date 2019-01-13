class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  EMAIL_DOMAIN_PERMISSION = "selleo.com".freeze

  devise :database_authenticatable,
         :registerable,
         :jwt_authenticatable,
         jwt_revocation_strategy: JWTBlacklist

  validates :email, uniqueness: true, presence: true
  validates :full_name, uniqueness: true, presence: true
  validate :check_email_domain_permission

  has_many :reservations

  private

  def check_email_domain_permission
    errors.add(:email, "only selleo email permitted") unless email.end_with?(EMAIL_DOMAIN_PERMISSION)
  end
end
