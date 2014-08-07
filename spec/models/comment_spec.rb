require 'spec_helper'

describe Comment do
  it 'body can not be blank' do
    c = Comment.new(idea_id: Idea.make!.id, creator: User.make)
    expect{ c.save! }.to raise_error ActiveRecord::RecordInvalid, /body/i
  end

  it 'idea_id can not be blank' do
    c = Comment.new(creator: User.make, body: 'O hai thar')
    expect{ c.save! }.to raise_error ActiveRecord::RecordInvalid, /idea/i
  end

  it 'user_id can not be blank' do
    c = Comment.new(idea_id: Idea.make!.id, body: 'O hai thar')
    expect{ c.save! }.to raise_error ActiveRecord::RecordInvalid, /creator/i
  end

  it 'should respond to idea' do
    c = Comment.make!
    expect(c).to respond_to(:idea)
  end
end
