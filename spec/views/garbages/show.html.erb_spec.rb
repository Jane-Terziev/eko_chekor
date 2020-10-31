require 'rails_helper'

RSpec.describe "garbages/show", type: :view do
  before(:each) do
    @garbage = assign(:garbage, Garbage.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
