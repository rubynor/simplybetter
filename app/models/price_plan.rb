class PricePlan < ActiveRecord::Base
  has_many :applications

  def self.plans_select
    PricePlan.all.order(price: :asc).map { |p| ["#{p.name} $#{p.price} - Up to #{p.max_users} users", p.id] }
  end

  def default?
    name == 'standard'
  end
end
