class User < ApplicationRecord
  has_many :hq_memberships
  has_many :headquarters, through: :hq_memberships
  has_many :project_memberships
  has_many :projects, through: :project_memberships

  has_secure_password

  before_create :generate_auth_token
  before_save :normalize_email

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  validates_presence_of :email, :name
  validates_uniqueness_of :email, case_sensitive: false
  validates_length_of :email, :name, maximum: 255
  validates_format_of :email, with: VALID_EMAIL_REGEX
  validates_length_of :password, minimum: 6, allow_blank: true

  include HeadquarterTenant
  include ProjectTenant

  private
  def generate_auth_token
    generate_token(:auth_token)
  end

  def normalize_email
    self.email = email.downcase
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end
end
