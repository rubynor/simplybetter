class Customer < ActiveRecord::Base
  has_secure_password
  has_many :features

  before_create :generate_token

  private

  def generate_token
    self.token = (0...8).map{(65+rand(26)).chr}.join
  end
end
