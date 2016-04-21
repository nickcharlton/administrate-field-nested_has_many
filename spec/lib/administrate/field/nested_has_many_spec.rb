require "administrate/field/nested_has_many"

describe Administrate::Field::NestedHasMany do
  describe "#to_partial_path" do
    it "returns a partial based on the page being rendered" do
      page = :show
      field = Administrate::Field::NestedHasMany.new(:relation, "/a.jpg", page)

      path = field.to_partial_path

      expect(path).to eq("/fields/nested_has_many/#{page}")
    end
  end
end
