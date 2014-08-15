class AbuseReportsController < ApplicationsController
  def index
    @reports = AbuseReport.for(@application)
  end

  private

  def set_application
    @application ||= current_customer.applications.find(params[:application_id]) if params[:application_id]
  end
end
