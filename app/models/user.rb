class User < ActiveRecord::Base
  has_paper_trail
  include Gravtastic
  gravtastic size: 50
  has_and_belongs_to_many :applications
  has_many :comments, as: :creator, inverse_of: :creator
  has_many :ideas, as: :creator
  has_many :votes, as: :voter

  validates :email,
    format: {
      with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, 
      on: :create},
    uniqueness: true,
    presence: true


  def verify_attributes(attributes)
    assign_attributes(attributes)
    save! if changed?
  end
end
