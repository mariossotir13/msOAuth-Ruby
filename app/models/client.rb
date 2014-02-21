class Client < User
  has_many :authorization_code_profiles
end
