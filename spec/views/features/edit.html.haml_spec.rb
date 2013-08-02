require 'spec_helper'

describe "features/edit" do
  before(:each) do
    @feature = assign(:feature, stub_model(Feature,
      :title => "MyString",
      :description => "MyText",
      :creator_id => 1
    ))
  end

  it "renders the edit feature form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", feature_path(@feature), "post" do
      assert_select "input#feature_title[name=?]", "feature[title]"
      assert_select "textarea#feature_description[name=?]", "feature[description]"
      assert_select "input#feature_creator_id[name=?]", "feature[creator_id]"
    end
  end
end
