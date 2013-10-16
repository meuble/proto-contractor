require 'spec_helper'

describe "races/new" do
  before(:each) do
    assign(:race, stub_model(Race,
      :title => "MyString",
      :prize => "MyText"
    ).as_new_record)
  end

  it "renders new race form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", races_path, "post" do
      assert_select "input#race_title[name=?]", "race[title]"
      assert_select "textarea#race_prize[name=?]", "race[prize]"
    end
  end
end
