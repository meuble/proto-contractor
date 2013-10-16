require 'spec_helper'

describe "bets/show" do
  before(:each) do
    @bet = assign(:bet, stub_model(Bet,
      :race_id => 1,
      :team_id => 2,
      :position => 3,
      :general => false,
      :user_id => 4,
      :user_uid => "User Uid"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/3/)
    rendered.should match(/false/)
    rendered.should match(/4/)
    rendered.should match(/User Uid/)
  end
end
