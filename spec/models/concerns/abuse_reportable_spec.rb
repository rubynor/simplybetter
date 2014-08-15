require 'spec_helper'

describe AbuseReportable do
  context 'on include with no reference to application' do
    it 'should raise an exception' do
      expect do
        class Dummy < ActiveRecord::Base
          include AbuseReportable
        end
      end.to raise_error
    end
  end
end
