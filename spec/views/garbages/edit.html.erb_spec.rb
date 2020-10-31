require 'rails_helper'

RSpec.describe "garbages/edit", type: :view do
  before(:each) do
    @garbage = assign(:garbage, Garbage.create!())
  end

  it "renders the edit garbage form" do
    render

    assert_select "form[action=?][method=?]", garbage_path(@garbage), "post" do
    end
  end
end
