class Application < ActiveRecord::Base
  extend Enumerize
  has_paper_trail
  has_and_belongs_to_many :customers
  has_and_belongs_to_many :users, join_table: 'widget_users'
  has_and_belongs_to_many :widget_customers, class_name: 'Customer', join_table: 'widget_customers'

  has_many :support_messages

  has_many :ideas, -> { order('votes_count DESC') }
  has_many :comments, -> { order('comments.votes_count DESC') }, through: :ideas
  has_many :notifications

  enumerize :icon, in: [:triangle, :circle], default: :triangle

  validates_uniqueness_of :token
  validates_presence_of :name

  validates :support_email,
            format: EmailValidator.validator,
            if: -> { support_email_changed? && (support_email.blank? ? self.support_email = nil : true)}
            #length TODO: OMA: er offline. husker ikke hvordan man validerer lengde hvis satt, minimum 1 tegn. nil skal her være godtatt og empty skal bli nil. Sorry, får det ikke til :)

  before_create :generate_token

  def support_emails
    support_email || customers.map(&:email).join(',')
  end

  private

  def generate_token
    self.token = (0...8).map{(65+rand(26)).chr}.join
  end
end
