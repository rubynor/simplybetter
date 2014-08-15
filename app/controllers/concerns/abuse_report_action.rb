module AbuseReportAction
  extend ActiveSupport::Concern

  included do
    unless self < CreatorFinder
      include CreatorFinder
    end
  end

  module ClassMethods
    def report_abuse_action model: nil, app: nil, user_param: nil
      if defined?(model)
        define_method "report_abuse" do
          record = model.find_by(params[:id])
          AbuseReport.create!(reportable: record, reporter: get_current_user(app, params[user_param]))
          render status: 200
        end
      else
        raise ArgumentError, "#{model} does not seem to be a valid constant"
      end
    end
  end
end