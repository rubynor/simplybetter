class User < ActiveRecord::Base
  has_paper_trail
  include Gravtastic
  include CustomerUserShared
  gravtastic size: 50
  has_and_belongs_to_many :widgets, class_name: 'Application', join_table: 'widget_users'
end
