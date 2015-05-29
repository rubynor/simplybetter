class Faq < ActiveRecord::Base
	belongs_to :application
	validates :application_id, :question, :answer, presence: true
end