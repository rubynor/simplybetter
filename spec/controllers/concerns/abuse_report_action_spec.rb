require 'spec_helper'

describe AbuseReportAction do
  class Dummy ; end
  class DummyController < ApplicationController
    include AbuseReportAction
    report_abuse_action model: Dummy, app: nil, user_param: nil
  end

  context 'when included into a class' do
    describe '.report_abuse_action' do
      it 'should create method report_abuse' do
        expect(DummyController.new).to respond_to(:report_abuse)
      end

      it 'should include the CreatorFinder concern' do
        expect(DummyController < CreatorFinder).to be_truthy
      end
    end
  end
end
