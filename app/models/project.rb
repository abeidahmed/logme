class Project < ApplicationRecord
  belongs_to :headquarter
  has_many :project_memberships
  has_many :users, through: :project_memberships

  before_save :normalize_url
  before_save :normalize_subdomain

  VALID_URL_REGEX = /\A(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$\z/ix

  validates_presence_of :name, :url, :subdomain
  validates_length_of :name, :url, maximum: 255
  validates_length_of :subdomain, maximum: 63
  validates_length_of :description, maximum: 500
  validates_uniqueness_of :subdomain, case_sensitive: false
  validates_format_of :url, with: VALID_URL_REGEX

  private
  def normalize_url
    self.url = url.downcase
  end

  def normalize_subdomain
    self.subdomain = subdomain.downcase
  end
end
