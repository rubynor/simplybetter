object @application
attributes :id, :name, :intro, :icon, :support_enabled, :support_email, :third_party_support, :faqs_enabled, :price_plan_id, :support_emails

node(:icons) do
  Application.icon.values
end

node(:priceplans) do
  PricePlan.plans_select
end
