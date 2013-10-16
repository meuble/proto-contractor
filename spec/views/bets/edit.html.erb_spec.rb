require 'spec_helper'

describe "bets/edit" do
  before(:each) do
    @bet = assign(:bet, stub_model(Bet,
      :race_id => 1,
      :team_id => 1,
      :position => 1,
      :general => false,
      :user_id => 1,
      :user_uid => "MyString"
    ))
  end

  it "renders the edit bet form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", bet_path(@bet), "post" do
      assert_select "input#bet_race_id[name=?]", "bet[race_id]"
      assert_select "input#bet_team_id[name=?]", "bet[team_id]"
      assert_select "input#bet_position[name=?]", "bet[position]"
      assert_select "input#bet_general[name=?]", "bet[general]"
      assert_select "input#bet_user_id[name=?]", "bet[user_id]"
      assert_select "input#bet_user_uid[name=?]", "bet[user_uid]"
    end
  end
end
