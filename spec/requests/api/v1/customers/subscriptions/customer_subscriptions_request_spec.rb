require 'rails_helper'

RSpec.describe 'Customer Subscription Requests' do
  describe '#create' do
    context 'when successful' do
      let!(:customer) { create(:customer) }
      let!(:subscription) { build(:subscription, customer: customer) }
      let!(:tea1) { create(:tea) }
      let!(:tea2) { create(:tea) }

      let!(:subscription_params) {
        {
          title: subscription.title,
          total_price: subscription.total_price,
          frequency: subscription.frequency,
          status:subscription.status,
          teas: [
            {
              tea_id: tea1.id,
            },
            {
              tea_id: tea2.id
            }
          ]
        }
      }

      it "starts a subscription for a customer" do
        post "/api/v1/customers/#{customer.id}/subscriptions", params: subscription_params

        expect(response.status).to eq(201)

        json = JSON.parse(response.body, symbolize_names: true)

        expect(json).to have_key(:data)
        expect(json[:data]).to be_a(Hash)

        subscription = json[:data]

        expect(subscription.keys).to eq([:id, :type, :attributes])
        expect(subscription[:id]).to be_a(String)
        expect(subscription[:type]).to be_a(String)
        expect(subscription[:attributes]).to be_a(Hash)

        attributes = subscription[:attributes]
        expect(attributes.keys).to eq([:title, :total_price, :frequency, :status, :teas])
        expect(attributes[:title]).to be_a(String)
        expect(attributes[:total_price]).to be_an(Integer)
        expect(attributes[:total_price]).to_not be_a(Float)
        expect(attributes[:status]).to be_a(String)
        expect(attributes[:frequency]).to be_a(String)
        expect(attributes[:teas]).to be_an(Array)

        teas = attributes[:teas]
        expect(teas.count).to eq(2)

        teas.each do |tea|
          expect(tea.keys).to eq([:title, :description, :temperature, :brew_time, :unit_price])
          expect(tea[:title]).to be_a(String)
          expect(tea[:description]).to be_a(String)
          expect(tea[:temperature]).to be_an(Integer)
          expect(tea[:brew_time]).to be_an(Integer)
          expect(tea[:unit_price]).to be_an(Integer)
        end
      end
    end
  end

  describe '#update' do
    context 'when successful' do
      let!(:customer) { create(:customer) }
      let!(:tea1) { create(:tea) }
      let!(:tea2) { create(:tea) }
      let!(:cancellation_params) {
        {
          "status": "Cancelled"
        }
      }
      before do
        @subscription = customer.subscriptions.create(attributes_for(:subscription))
        TeaSubscription.create(subscription_id: @subscription.id, tea_id: tea1.id)
        TeaSubscription.create(subscription_id: @subscription.id, tea_id: tea2.id)
      end

      it "can change the status of a subscription to 'Cancelled'" do
        patch "/api/v1/customers/#{customer.id}/subscriptions/#{@subscription.id}", params: cancellation_params

        expect(response.status).to eq(200)

        json = JSON.parse(response.body, symbolize_names: true)
        expect(json).to have_key(:data)
        expect(json[:data]).to be_a(Hash)

        subscription = json[:data]

        expect(subscription.keys).to eq([:id, :type, :attributes])
        expect(subscription[:id]).to be_a(String)
        expect(subscription[:type]).to be_a(String)
        expect(subscription[:attributes]).to be_a(Hash)

        attributes = subscription[:attributes]
        expect(attributes.keys).to eq([:title, :total_price, :frequency, :status, :teas])
        expect(attributes[:title]).to be_a(String)
        expect(attributes[:total_price]).to be_an(Integer)
        expect(attributes[:total_price]).to_not be_a(Float)
        expect(attributes[:status]).to eq('Cancelled')
        expect(attributes[:frequency]).to be_a(String)
        expect(attributes[:teas]).to be_an(Array)

        teas = attributes[:teas]
        expect(teas.count).to eq(2)

        teas.each do |tea|
          expect(tea.keys).to eq([:title, :description, :temperature, :brew_time, :unit_price])
          expect(tea[:title]).to be_a(String)
          expect(tea[:description]).to be_a(String)
          expect(tea[:temperature]).to be_an(Integer)
          expect(tea[:brew_time]).to be_an(Integer)
          expect(tea[:unit_price]).to be_an(Integer)
        end
      end
    end
  end
end
