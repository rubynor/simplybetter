class PricePlan < ActiveRecord::Base
  has_many :applications

  def self.plans_select
    PricePlan.all.map { |p| ["#{p.name} $#{p.price}", p.id] }
  end

  def default?
    name == 'standard'
  end
end
