require 'spec_helper'

describe "results/edit" do
  before(:each) do
    @result = assign(:result, stub_model(Result,
      :race_id => 1,
      :team_id => 1,
      :position => 1
    ))
  end

  it "renders the edit result form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", result_path(@result), "post" do
      assert_select "input#result_race_id[name=?]", "result[race_id]"
      assert_select "input#result_team_id[name=?]", "result[team_id]"
      assert_select "input#result_position[name=?]", "result[position]"
    end
  end
end
