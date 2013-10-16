require 'spec_helper'

describe "products/show" do
  before(:each) do
    @product = assign(:product, stub_model(Product,
      :title => "Title",
      :city => "City",
      :zipcode => "Zipcode",
      :lat => "Lat",
      :lng => "Lng",
      :picture => "Picture",
      :label => "Label"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    rendered.should match(/City/)
    rendered.should match(/Zipcode/)
    rendered.should match(/Lat/)
    rendered.should match(/Lng/)
    rendered.should match(/Picture/)
    rendered.should match(/Label/)
  end
end
