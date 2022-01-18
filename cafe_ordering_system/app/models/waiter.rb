class Waiter < ApplicationRecord
  has_secure_password
  has_many :orders

  validates :name, presence: true
  validates :email, presence: true
  validates :password, presence: true 
  validates :phone, presence: true
  validates :address, presence: true
  validates :birthday, presence: true
end
