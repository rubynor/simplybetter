require 'spec_helper'

describe CreatorFinder do

  before :all do
    class FakesController < ApplicationController
      include CreatorFinder
    end
  end

  after :all do
    Object.send :remove_const, :FakesController
  end

  let(:object) { FakesController.new }

  it 'returns a user' do
    @user = User.make!
    @app = Application.make!
    @user.applications << @app
    object.get_current_user(@app, @user.email).should eq(@user)
  end

  it 'returns a customer' do
    @user = Customer.make!
    @app = Application.make!
    @user.applications << @app
    object.get_current_user(@app, @user.email).should eq(@user)
  end

  it 'raises error if user not part of application' do
    @user = User.make!
    @app = Application.make!
    expect{ object.get_current_user(@app, @user.email) }.to raise_error
  end

  it 'raises error if customer not part of application' do
    @user = Customer.make!
    @app = Application.make!
    expect{ object.get_current_user(@app, @user.email) }.to raise_error
  end

  it 'raises NoUserException' do
    @app = Application.make!
    expect{ object.get_current_user(@app, 'kj') }.to raise_error(NoUserException)
  end

  it 'raises ArgumentError if missing argument' do
    expect{ object.get_current_user(nil, 'kj') }.to raise_error(ArgumentError)
  end

end