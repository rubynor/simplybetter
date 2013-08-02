require 'spec_helper'

describe Feature do
  it 'should have a title' do
    f = Feature.new(description: "Hey!")
    expect{ f.save! }.to raise_error ActiveRecord::RecordInvalid, /title/i
  end
  it 'should have a body' do
    f = Feature.new(title: "hey")
    expect{ f.save! }.to raise_error ActiveRecord::RecordInvalid, /description/i
  end
end