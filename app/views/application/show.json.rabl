object @application
attributes :name, :intro, :icon, :support_enabled, :support_email, :third_party_support, :faqs_enabled

node(:icons) do
  Application.icon.values
end
