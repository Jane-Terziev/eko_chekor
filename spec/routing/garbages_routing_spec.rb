require "rails_helper"

RSpec.describe GarbagesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/garbages").to route_to("garbages#index")
    end

    it "routes to #new" do
      expect(get: "/garbages/new").to route_to("garbages#new")
    end

    it "routes to #show" do
      expect(get: "/garbages/1").to route_to("garbages#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/garbages/1/edit").to route_to("garbages#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/garbages").to route_to("garbages#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/garbages/1").to route_to("garbages#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/garbages/1").to route_to("garbages#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/garbages/1").to route_to("garbages#destroy", id: "1")
    end
  end
end
