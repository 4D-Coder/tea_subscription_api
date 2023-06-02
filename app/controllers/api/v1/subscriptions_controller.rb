class Api::V1::SubscriptionsController < ApplicationController
  def index
    begin
      customer_subscriptions = Subscription.where(customer_id: index_params['customer_id'])

      render json: SubscriptionSerializer.new(customer_subscriptions), status: 200
    end
  end

  def create
    subscription = Subscription.new(create_params)

    begin
      subscription.save
      params['teas'].each do |tea|
        tea = Tea.find(tea['tea_id'])
        TeaSubscription.create(subscription_id: subscription.id, tea_id: tea.id)
      end

      render json: SubscriptionSerializer.new(subscription), status: 201
    end
  end

  def update
    subscription = Subscription.find(update_params['id'])

    if subscription.status != update_params['status']
      subscription.update(status: update_params['status'])
      render json: SubscriptionSerializer.new(subscription), status: 200
    end
  end

  private

  def create_params
    params.permit(
      :customer_id,
      :title,
      :total_price,
      :frequency,
      :status
    )
  end

  def update_params
    params.permit(
      :status,
      :customer_id,
      :id
    )
  end

  def index_params
    params.permit(
      :customer_id
    )
  end
end
