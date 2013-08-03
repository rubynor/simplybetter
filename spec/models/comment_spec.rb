require 'spec_helper'

describe Comment do
  it 'body can not be blank' do
    c = Comment.new(feature_id: Feature.make!.id, creator: User.make)
    expect{ c.save! }.to raise_error ActiveRecord::RecordInvalid, /body/i
  end

  it 'feature_id can not be blank' do
    c = Comment.new(creator: User.make, body: 'O hai thar')
    expect{ c.save! }.to raise_error ActiveRecord::RecordInvalid, /feature/i
  end

  it 'user_id can not be blank' do
    c = Comment.new(feature_id: Feature.make!.id, body: 'O hai thar')
    expect{ c.save! }.to raise_error ActiveRecord::RecordInvalid, /creator/i
  end

  it 'should respond to feature' do
    c = Comment.make!
    c.should respond_to(:feature)
  end
end
