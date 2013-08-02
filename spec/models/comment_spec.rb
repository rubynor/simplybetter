require 'spec_helper'

describe Comment do
  it 'body can not be blank' do
    c = Comment.new(feature_id: Feature.make!.id,user_id: User.make!.id)
    expect{ c.save! }.to raise_error ActiveRecord::RecordInvalid, /body/i
  end

  it 'feature_id can not be blank' do
    c = Comment.new(user_id: User.make!.id, body: 'O hai thar')
    expect{ c.save! }.to raise_error ActiveRecord::RecordInvalid, /feature/i
  end

  it 'user_id can not be blank' do
    c = Comment.new(feature_id: Feature.make!.id, body: 'O hai thar')
    expect{ c.save! }.to raise_error ActiveRecord::RecordInvalid, /user/i
  end

  it 'should respond to user' do
    c = Comment.make!
    c.should respond_to(:user)
  end

  it 'should respond to feature' do
    c = Comment.make!
    c.should respond_to(:feature)
  end
end
