require 'rails_helper'

RSpec.describe "garbages/new", type: :view do
  before(:each) do
    assign(:garbage, Garbage.new())
  end

  it "renders new garbage form" do
    render

    assert_select "form[action=?][method=?]", garbages_path, "post" do
    end
  end
end
