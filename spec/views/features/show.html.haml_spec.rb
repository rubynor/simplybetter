require 'spec_helper'

describe "features/show" do
  before(:each) do
    @feature = assign(:feature, stub_model(Feature,
      :title => "Title",
      :description => "MyText",
      :creator_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    rendered.should match(/MyText/)
    rendered.should match(/1/)
  end
end
