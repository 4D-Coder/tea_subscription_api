class Customer < ApplicationRecord
  validates :first_name,
            :last_name,
            :email,
            :address,
            presence: :true

  validates :email, uniqueness: :true

  has_many :subscriptions
  has_many :tea_subscriptions, through: :subscriptions
  has_many :teas, through: :tea_subscriptions
end
