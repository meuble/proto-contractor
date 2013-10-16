require 'spec_helper'

describe "products/new" do
  before(:each) do
    assign(:product, stub_model(Product,
      :title => "MyString",
      :city => "MyString",
      :zipcode => "MyString",
      :lat => "MyString",
      :lng => "MyString",
      :picture => "MyString",
      :label => "MyString"
    ).as_new_record)
  end

  it "renders new product form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", products_path, "post" do
      assert_select "input#product_title[name=?]", "product[title]"
      assert_select "input#product_city[name=?]", "product[city]"
      assert_select "input#product_zipcode[name=?]", "product[zipcode]"
      assert_select "input#product_lat[name=?]", "product[lat]"
      assert_select "input#product_lng[name=?]", "product[lng]"
      assert_select "input#product_picture[name=?]", "product[picture]"
      assert_select "input#product_label[name=?]", "product[label]"
    end
  end
end
