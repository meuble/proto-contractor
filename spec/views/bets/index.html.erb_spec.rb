require 'spec_helper'

describe "bets/index" do
  before(:each) do
    assign(:bets, [
      stub_model(Bet,
        :race_id => 1,
        :team_id => 2,
        :position => 3,
        :general => false,
        :user_id => 4,
        :user_uid => "User Uid"
      ),
      stub_model(Bet,
        :race_id => 1,
        :team_id => 2,
        :position => 3,
        :general => false,
        :user_id => 4,
        :user_uid => "User Uid"
      )
    ])
  end

  it "renders a list of bets" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => "User Uid".to_s, :count => 2
  end
end
