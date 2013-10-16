require 'spec_helper'

describe "products/index" do
  before(:each) do
    assign(:products, [
      stub_model(Product,
        :title => "Title",
        :city => "City",
        :zipcode => "Zipcode",
        :lat => "Lat",
        :lng => "Lng",
        :picture => "Picture",
        :label => "Label"
      ),
      stub_model(Product,
        :title => "Title",
        :city => "City",
        :zipcode => "Zipcode",
        :lat => "Lat",
        :lng => "Lng",
        :picture => "Picture",
        :label => "Label"
      )
    ])
  end

  it "renders a list of products" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "City".to_s, :count => 2
    assert_select "tr>td", :text => "Zipcode".to_s, :count => 2
    assert_select "tr>td", :text => "Lat".to_s, :count => 2
    assert_select "tr>td", :text => "Lng".to_s, :count => 2
    assert_select "tr>td", :text => "Picture".to_s, :count => 2
    assert_select "tr>td", :text => "Label".to_s, :count => 2
  end
end
