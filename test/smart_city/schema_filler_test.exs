defmodule SmartCity.SchemaFillerTest do
  use ExUnit.Case
  doctest SmartCity.Helpers
  alias SmartCity.SchemaFiller

  describe "single level" do
    test "nil map" do
      schema = [
        %{name: "id", type: "string"},
        %{
          name: "parent",
          type: "map",
          subSchema: [%{name: "childA", type: "string"}, %{name: "childB", type: "string"}]
        }
      ]

      payload = %{id: "id", parent: nil}

      expected = %{
        id: "id",
        parent: nil
      }

      actual = SchemaFiller.fill(payload, schema)

      assert expected == actual
    end

    # test "empty map" do
    #   schema = [
    #     %{name: "id", type: "string"},
    #     %{
    #       name: "parent",
    #       type: "map",
    #       subSchema: [%{name: "childA", type: "string"}, %{name: "childB", type: "string"}]
    #     }
    #   ]

    #   payload = %{id: "id", parent: %{}}

    #   expected = %{
    #     id: "id",
    #     parent: nil
    #   }

    #   actual = SchemaFiller.fill(payload, schema)

    #   assert expected == actual
    # end

    # test "partial map" do
    #   schema = [
    #     %{name: "id", type: "string"},
    #     %{
    #       name: "parent",
    #       type: "map",
    #       subSchema: [%{name: "childA", type: "string"}, %{name: "childB", type: "string"}]
    #     }
    #   ]

    #   payload = %{id: "id", parent: %{childA: "childA"}}

    #   expected = %{
    #     id: "id",
    #     parent: %{childA: "childA", childB: nil}
    #   }

    #   actual = SchemaFiller.fill(payload, schema)

    #   assert expected == actual
    # end

    # test "empty list" do
    #   schema = [
    #     %{name: "id", type: "string"},
    #     %{
    #       name: "parent",
    #       type: "list",
    #       itemType: "string"
    #     }
    #   ]

    #   payload = %{id: "id", parent: []}

    #   expected = %{
    #     id: "id",
    #     parent: []
    #   }

    #   actual = SchemaFiller.fill(payload, schema)
    #   assert expected == actual
    # end

    # test "list with string item" do
    #   schema = [
    #     %{name: "id", type: "string"},
    #     %{
    #       name: "parent",
    #       type: "list",
    #       itemType: "string"
    #     }
    #   ]

    #   payload = %{id: "id", parent: ["thing"]}

    #   expected = %{
    #     id: "id",
    #     parent: ["thing"]
    #   }

    #   actual = SchemaFiller.fill(payload, schema)
    #   assert expected == actual
    # end
  end

  # describe "two levels" do
  #   test "list with empty map" do
  #     schema = [
  #       %{name: "id", type: "string"},
  #       %{
  #         name: "parent",
  #         type: "list",
  #         itemType: "map",
  #         subSchema: [%{name: "childA", type: "string"}, %{name: "childB", type: "string"}]
  #       }
  #     ]

  #     payload = %{id: "id", parent: [%{}]}

  #     # Should this be empty list or nil?
  #     expected = %{
  #       id: "id",
  #       parent: []
  #     }

  #     actual = SchemaFiller.fill(payload, schema)
  #     assert expected == actual
  #   end

  #   test "list with partial map" do
  #     schema = [
  #       %{name: "id", type: "string"},
  #       %{
  #         name: "parent",
  #         type: "list",
  #         itemType: "map",
  #         subSchema: [%{name: "childA", type: "string"}, %{name: "childB", type: "string"}]
  #       }
  #     ]

  #     payload = %{id: "id", parent: [%{childA: "childA"}]}

  #     expected = %{
  #       id: "id",
  #       parent: [%{childA: "childA", childB: nil}]
  #     }

  #     actual = SchemaFiller.fill(payload, schema)
  #     assert expected == actual
  #   end

  #   test "list with 2 partial maps" do
  #     schema = [
  #       %{name: "id", type: "string"},
  #       %{
  #         name: "parent",
  #         type: "list",
  #         itemType: "map",
  #         subSchema: [%{name: "childA", type: "string"}, %{name: "childB", type: "string"}]
  #       }
  #     ]

  #     payload = %{id: "id", parent: [%{childA: "childA"}, %{childB: "childB"}]}

  #     expected = %{
  #       id: "id",
  #       parent: [%{childA: "childA", childB: nil}, %{childA: nil, childB: "childB"}]
  #     }

  #     actual = SchemaFiller.fill(payload, schema)
  #     assert expected == actual
  #   end

  #   test "nil grandparent" do
  #     schema = [
  #       %{name: "id", type: "string"},
  #       %{
  #         name: "grandParent",
  #         type: "map",
  #         subSchema: [
  #           %{
  #             name: "parent",
  #             type: "map",
  #             subSchema: [%{name: "childA", type: "string"}, %{name: "childB", type: "string"}]
  #           }
  #         ]
  #       }
  #     ]

  #     payload = %{id: "id", grandParent: %{}}

  #     expected = %{
  #       id: "id",
  #       grandParent: nil
  #     }

  #     actual = SchemaFiller.fill(payload, schema)

  #     assert expected == actual
  #   end

  #   test "map with empty map" do
  #     schema = [
  #       %{name: "id", type: "string"},
  #       %{
  #         name: "grandParent",
  #         type: "map",
  #         subSchema: [
  #           %{
  #             name: "parent",
  #             type: "map",
  #             subSchema: [%{name: "childA", type: "string"}, %{name: "childB", type: "string"}]
  #           }
  #         ]
  #       }
  #     ]

  #     payload = %{id: "id", grandParent: %{parent: %{}}}

  #     expected = %{
  #       id: "id",
  #       grandParent: %{parent: nil}
  #     }

  #     actual = SchemaFiller.fill(payload, schema)

  #     assert expected == actual
  #   end

  #   test "map with partial map" do
  #     schema = [
  #       %{name: "id", type: "string"},
  #       %{
  #         name: "grandParent",
  #         type: "map",
  #         subSchema: [
  #           %{
  #             name: "parent",
  #             type: "map",
  #             subSchema: [%{name: "childA", type: "string"}, %{name: "childB", type: "string"}]
  #           }
  #         ]
  #       }
  #     ]

  #     payload = %{id: "id", grandParent: %{parent: %{childA: "childA"}}}

  #     expected = %{
  #       id: "id",
  #       grandParent: %{parent: %{childA: "childA", childB: nil}}
  #     }

  #     actual = SchemaFiller.fill(payload, schema)

  #     assert expected == actual
  #   end
  # end
end
