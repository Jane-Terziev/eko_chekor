require 'rails_helper'

RSpec.describe "garbages/index", type: :view do
  before(:each) do
    assign(:garbages, [
      Garbage.create!(),
      Garbage.create!()
    ])
  end

  it "renders a list of garbages" do
    render
  end
end
