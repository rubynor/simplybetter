module ApplicationsHelper
  def price_plans
    PricePlan.plans_select
  end
end
