defmodule SmartCity.SchemaFillerTest do
  use ExUnit.Case
  doctest SmartCity.Helpers
  alias SmartCity.SchemaFiller

  describe "merge payload with nil map" do
    test "empty map" do
      schema = [
        %{name: "id", type: "string"},
        %{
          name: "greatGrandParent",
          type: "map",
          subSchema: [
            %{name: "grandParentSibling", type: "string"},
            %{
              name: "grandParent",
              type: "map",
              subSchema: [
                %{
                  name: "parent",
                  type: "map",
                  subSchema: [%{name: "childA", type: "string"}, %{name: "childB", type: "string"}]
                }
              ]
            }
          ]
        }
      ]

      payload = %{id: "id", greatGrandParent: %{grandParent: %{}, grandParentSibling: "sibling"}}

      expected = %{
        id: "id",
        greatGrandParent: %{grandParentSibling: "sibling", grandParent: %{parent: %{childA: nil, childB: nil}}}
      }

      actual = SchemaFiller.fill(payload, schema)

      assert expected == actual
    end

    # test "nil value" do
    #   schema = [
    #     %{name: "id", type: "string"},
    #     %{
    #       name: "grandParent",
    #       type: "map",
    #       subSchema: [
    #         %{
    #           name: "parent",
    #           type: "map",
    #           subSchema: [%{name: "childA", type: "string"}, %{name: "childB", type: "string"}]
    #         }
    #       ]
    #     }
    #   ]

    #   payload = %{id: "id", grandParent: nil}

    #   expected = %{id: "id", grandParent: %{parent: %{childA: nil, childB: nil}}}

    #   nil_map = Helpers.empty_map_from_schema(schema)
    #   actual = Helpers.merge_empty(nil_map, payload)

    #   assert expected == actual
    # end

    # test "arrays" do
    #   schema = [
    #     %{name: "id", type: "string"},
    #     %{
    #       name: "grandParent",
    #       type: "list",
    #       itemType: "map",
    #       subSchema: [
    #         %{
    #           name: "parent",
    #           type: "list",
    #           itemType: "map",
    #           subSchema: [%{name: "childA", type: "string"}, %{name: "childB", type: "string"}]
    #         }
    #       ]
    #     }
    #   ]

    #   payload = %{id: "id", grandParent: %{}}

    #   expected = %{id: "id", grandParent: [%{parent: %{childA: nil, childB: nil}}]}

    #   nil_map = Helpers.empty_map_from_schema(schema)
    #   IO.inspect(nil_map, label: "nil map")
    #   actual = Helpers.merge_empty(nil_map, payload)

    #   assert expected == actual
    # end
  end
end
