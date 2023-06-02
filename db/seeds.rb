# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

    TeaSubscription.destroy_all
    Tea.destroy_all
    Subscription.destroy_all
    Customer.destroy_all

    ActiveRecord::Base.connection.reset_pk_sequence!('teas')
    ActiveRecord::Base.connection.reset_pk_sequence!('customers')
    ActiveRecord::Base.connection.reset_pk_sequence!('subscriptions')

    4.times do
      FactoryBot.create(:tea)
    end

    tea1 = Tea.first
    tea2 = Tea.second

    customer1 = FactoryBot.create(:customer)
    subscription1 = FactoryBot.create(:subscription, customer_id: customer1.id)

    TeaSubscription.create(subscription_id: subscription1.id, tea_id: tea1.id)
    TeaSubscription.create(subscription_id: subscription1.id, tea_id: tea2.id)


