require 'spec_helper'

describe CreatorFinder do

  class TestClass < ApplicationController
    include CreatorFinder
    attr_accessor :params

    def initialize(params)
      self.params = params
    end
  end

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
    @user.widgets << @app
    expect(object.send(:get_current_user, @app, @user.email)).to eq(@user)
  end

  it 'returns a customer' do
    @user = Customer.make!
    @app = Application.make!
    @user.widgets << @app
    expect(object.send(:get_current_user, @app, @user.email)).to eq(@user)
  end

  it 'raises error if user not part of application' do
    @user = User.make!
    @app = Application.make!
    expect{ object.send(:get_current_user, @app, @user.email) }.to raise_error
  end

  it 'raises error if customer not part of application' do
    @user = Customer.make!
    @app = Application.make!
    expect{ object.send(:get_current_user, @app, @user.email)}.to raise_error
  end

  it 'raises NoUserException' do
    @app = Application.make!
    expect{ object.send(:get_current_user, @app, 'kj') }.to raise_error(NoUserException)
  end

  it 'raises ArgumentError if missing argument' do
    expect{ object.send(:get_current_user, nil, 'kj') }.to raise_error(ArgumentError)
  end

  it 'kj' do
    url_params = "?appkey=test&email=testemail&name=testname"
    test = TestClass.new({"info" => Base64.encode64(url_params)})
    test.decode_params
    expect(test.params["appkey"]).to eq('test')
    expect(test.params["email"]).to eq('testemail')
    expect(test.params["name"]).to eq('testname')
  end

end
