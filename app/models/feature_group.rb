class FeatureGroup < ActiveRecord::Base
  has_many :features
  belongs_to :application
end