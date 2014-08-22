require 'spec_helper'

RSpec.describe AbuseReport, :type => :model do
  describe 'for' do
    it 'should return all abuse reports for the given application' do
      app = Application.make!
      AbuseReport.make! application_id: app.id
      AbuseReport.make! application_id: app.id
      reports = AbuseReport.for(app)
      expect(reports.length).to eql(2)
    end
  end
end
