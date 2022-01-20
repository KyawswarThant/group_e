class Chef < ApplicationRecord
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true
  validates :password, presence: true, on: :create
  validates :password, confirmation: true, on: :update
  validates :phone, presence: true
  validates :address, presence: true
  validates :birthday, presence: true
end
