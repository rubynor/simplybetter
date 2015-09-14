class ReportsController < ApplicationController
  before_action :authorize_superadmin

  def overview
    @applications = Application.all

    @counts = {
        customers: {
            all: Customer.all.count,
            with_applications: Report::Customer.with_applications.count
        },
        apps: {
            all: @applications.count,
            with_ideas: Report::Application.with_ideas.count,
            with_comments: Report::Application.with_comments.count,
            with_users: Report::Application.with_users.count,
            with_support_enabled: Report::Application.with_support_enabled.count,
            with_faqs_enabled: Report::Application.with_faqs_enabled.count,
            with_third_party_support: Report::Application.with_third_party_support.count
        }
    }

    # @counts = {
    #     customers: Customer.all.count,
    #     customers_with_applications: Report::Customer.with_applications.count,
    #     apps: @applications.count,
    #     apps_with_ideas: Report::Application.with_ideas.count,
    #     apps_with_comments: Report::Application.with_comments.count,
    #     apps_with_users: Report::Application.with_users.count
    # }
  end
end
