class Idea < ActiveRecord::Base
  has_paper_trail
  searchkick autocomplete: [:title]

  belongs_to :application
  belongs_to :creator, polymorphic: true
  has_many :votes, as: :vote_receiver, dependent: :destroy
  has_many :comments, inverse_of: :idea, dependent: :destroy
  has_many :idea_subscriptions, dependent: :destroy
  has_many :notifications, as: :subject, dependent: :destroy

  validates_presence_of :title, :description, :creator, :application
  validates_uniqueness_of :title, scope: :application

  include IdeaNotificationHelpers

  scope :visible, -> { where(visible: true) }

  def save_and_notify(params, current_customer)
    creator = params.delete(:creator)
    assign_attributes(params)
    self.creator = find_creator(params[:creator]) if creator
    completed = has_been_completed?
    if save
      if completed
        Thread.abort_on_exception = true
        Thread.new do
          notify(action_attr: :completed, action_attr_changer: current_customer)
          UserNotifier.notify_group_completed(self.subscribers, current_customer, self)
          ActiveRecord::Base.connection.close
        end
      end
      true
    else
      self.reload
      false
    end
  end

  def widget_save_and_notify(app, creator)
    self.application = app
    self.creator = creator # From module
    if self.save
      Thread.abort_on_exception = true
      t = Thread.new do
        notify_customers
        subscribe
        AdminNotifier.send_to_group(app.customers, self.creator, self)
        ActiveRecord::Base.connection.close
      end
      at_exit { t.join }
      true
    else
      false
    end
  end

  def subscribers
    self.idea_subscriptions.map(&:subscriber).uniq
  end

  def subscribe
    IdeaSubscription.add(self, self.creator, self)
  end

  def mine?(user)
    self.creator == user
  end

  def upvotes
    votes.where("value > 0").count
  end

  def downvotes
    votes.where("value < 0").count
  end 

  def voter_status(voter)
    votes.find_by(voter: voter).try(:value) if voter
  end

  def update_votes_count
    self.update_attribute(:votes_count, votes.sum(:value))
  end

  def find_creator(string)
    string_arry = string.split(",")
    klass = string_arry.first
    id = string_arry.last.to_i
    klass.constantize.find id
  end

  def has_been_completed?
    completed_changed? && completed?
  end

  private

  def self.application(token)
    Application.find_by(token: token)
  end
end
