class Application < ActiveRecord::Base
  belongs_to :customer
  has_many :features

  validates_uniqueness_of :token

  before_create :generate_token

  private

  def generate_token
    self.token = (0...8).map{(65+rand(26)).chr}.join
  end
end
