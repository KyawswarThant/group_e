class Waiter < ApplicationRecord
  has_secure_password
  has_many :orders
end
