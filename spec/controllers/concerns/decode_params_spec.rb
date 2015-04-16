require 'spec_helper'
require 'base64'

describe DecodeParams do
  class TestClass < ApplicationController
    include DecodeParams
    attr_accessor :params

    def initialize(params)
      self.params = params
    end
  end

  it 'should decode a base64 string and assign params' do
    urlParams = "?appkey=test&email=testemail&name=testname"
    test = TestClass.new({"info" => Base64.encode64(urlParams)})
    test.decode_params
    expect(test.params["appkey"]).to eq('test')
    expect(test.params["email"]).to eq('testemail')
    expect(test.params["name"]).to eq('testname')
  end
end

