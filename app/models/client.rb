class Client < User
  validates :app_title, :client_type, :email, :id, :password, :redirection_uri, presence: true
  validates :app_title, length: { maximum: 120 }
  validates :id, length: { maximum: 43 }
  validates :id, uniqueness: true

  has_many :authorization_code_profiles
end
