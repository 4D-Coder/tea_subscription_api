class Subscription < ApplicationRecord
  validates :title,
            :total_price,
            :frequency,
            :status,
            presence: true

  belongs_to :customer
  has_many :tea_subscriptions
  has_many :teas, through: :tea_subscriptions

  enum status: ["Cancelled", "Active"]
end
