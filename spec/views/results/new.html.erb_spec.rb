require 'spec_helper'

describe "results/new" do
  before(:each) do
    assign(:result, stub_model(Result,
      :race_id => 1,
      :team_id => 1,
      :position => 1
    ).as_new_record)
  end

  it "renders new result form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", results_path, "post" do
      assert_select "input#result_race_id[name=?]", "result[race_id]"
      assert_select "input#result_team_id[name=?]", "result[team_id]"
      assert_select "input#result_position[name=?]", "result[position]"
    end
  end
end
