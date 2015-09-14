class ReportsController < ApplicationController
  before_action :authorize_superadmin

  def overview
    @applications = Application.all

    @counts = {
        apps: @applications.count,
        customers: Customer.all.count,
        apps_with_ideas:Report::Application.with_ideas.count,
        apps_with_comments: Report::Application.with_comments.count,
        apps_with_users: Report::Application.with_users.count,
        customers_with_applications: Report::Customer.with_applications.count
    }
  end
end
