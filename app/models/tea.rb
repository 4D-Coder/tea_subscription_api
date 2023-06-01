class Tea < ApplicationRecord
  validates :description,
            :temperature,
            :brew_time,
            :unit_price,
            presence: true

  validates_numericality_of :unit_price, only_integer: true

  has_many :tea_subscriptions
  has_many :subscriptions, through: :tea_subscriptions
end
