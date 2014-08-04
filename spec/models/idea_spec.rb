require 'spec_helper'

describe Idea do

  before :each do
    @idea = Idea.make!
    @application = @idea.application
    @customer = Customer.make!
    @customer.applications << @application
  end

  let(:user) { User.make! }

  let(:valid_attributes) do
    {
        title: 'My awesom idea',
        description: 'A little description',
        creator: user,
        application: @application
    }
  end

  describe 'validations' do
    subject { Idea.new(valid_attributes) }
    it { should_not have_valid(:title).when(nil) }
    it { should_not have_valid(:description).when(nil) }
    it { should_not have_valid(:creator).when(nil) }
    it { should_not have_valid(:application).when(nil) }
    it { should_not have_valid(:title).when(@idea.title) }
  end

  describe '#widget_save_and_notify' do
    it 'creates a new idea' do
      expect do
        Idea.new(valid_attributes).widget_save_and_notify(@application, user)
      end.to change( Idea, :count ).by 1
    end
    it 'subscribes the creator to idea notifications' do
      expect do
        Idea.new(valid_attributes).widget_save_and_notify(@application, user)
      end.to change { IdeaSubscription.count }.by 1
    end
    it 'notifies admin/customer about new idea' do
      expect do
        Idea.new(valid_attributes).widget_save_and_notify(@application, user)
      end.to change( Notification, :count).by 1
    end
    it 'returns false if not valid' do
      valid_attributes[:title] = nil
      expect do
        Idea.new(valid_attributes).widget_save_and_notify(@application, user)
      end.to_not change( Idea, :count )
    end
  end

  describe '#save_and_notify' do
    before :each do
      @idea.subscribe
    end

    it 'notifies idea owner of completed' do
      expect do
        @idea.save_and_notify({completed: true}, @customer)
      end.to change(Notification, :count).by 1
    end
  end
end
