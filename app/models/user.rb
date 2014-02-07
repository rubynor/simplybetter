class User < ActiveRecord::Base
  include Gravtastic
  gravtastic size: 50
  validates :email, uniqueness: {scope: :application}, presence: true
  belongs_to :application
  has_many :comments, as: :creator, inverse_of: :creator
  has_many :ideas, as: :creator
  has_many :votes

  def verify_attributes(attributes)
    assign_attributes(attributes)
    save! if changed?
  end
end
