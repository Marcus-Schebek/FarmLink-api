class AppUser < ApplicationRecord
  has_secure_password

  has_many :animals, foreign_key: "id_owner"
  has_many :sales_as_seller, class_name: "Sale", foreign_key: "id_seller"
  has_many :sales_as_buyer, class_name: "Sale", foreign_key: "id_buyer"

  validates :email, presence: true, uniqueness: true
end
