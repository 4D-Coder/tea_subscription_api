require 'rails_helper'

RSpec.describe 'Customer Subscription Requests' do
  describe '#create' do

    context 'when successful' do
      let!(:customer) { create(:customer) }
      let!(:subscription) { build(:subscription, customer: customer) }
      let!(:subscription_params) {
        {
          customer_id: subscription.customer_id,
          title: subscription.title,
          total_price: subscription.total_price,
          frequency: subscription.frequency,
          status:subscription.status
        }
      }

      it "starts a subscription for a customer" do
        post "/api/v1/customers/#{customer.id}/subscriptions", params: subscription_params

        require 'pry'; binding.pry
      end
    end
  end
end
