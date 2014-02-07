require 'spec_helper'

describe Idea do
  it 'should have a title' do
    f = Idea.new(description: "Hey!")
    expect{ f.save! }.to raise_error ActiveRecord::RecordInvalid, /title/i
  end
  it 'should have a body' do
    f = Idea.new(title: "hey")
    expect{ f.save! }.to raise_error ActiveRecord::RecordInvalid, /description/i
  end

  it 'should respond to comments' do
    f = Idea.make!
    f.should respond_to :comments
  end
end
