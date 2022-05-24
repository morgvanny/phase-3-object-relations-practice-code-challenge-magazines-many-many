class Reader < ActiveRecord::Base
  has_many :subscriptions
  has_many :magazines, through: :subscriptions

  def subscribe(magazine, price)
    self.subscriptions.create(magazine: magazine, price: price)
  end

  def total_subscription_price
    self.subscriptions.sum(:price)
  end

  def cancel_subscription(magazine)
    Subscription.find_by(magazine: magazine, reader: self).destroy

    # OR start with the already associated subscriptions and just find by magazine:
    # subscriptions.find_by(magazine: magazine).destroy
  end
end