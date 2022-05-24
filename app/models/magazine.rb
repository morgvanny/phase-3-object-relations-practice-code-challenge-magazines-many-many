class Magazine < ActiveRecord::Base
  has_many :subscriptions
  has_many :readers, through: :subscriptions

  def email_list
    readers.pluck(:email).join(";")
  end

  def self.most_popular
    all.max_by do |magazine|
      magazine.subscriptions.count
    end
    # Fancy AR more effecient way:
    # joins(:subscriptions).group("magazines.id").order("COUNT(subscriptions.id) desc").first
  end
end