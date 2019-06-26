defmodule SmartCity.SchemaFiller do
  def fill(schema, payload) do
    Enum.reduce(schema, payload, &reducer/2)
  end

  defp reducer(%{name: name, type: "map", subSchema: subSchema} = field, payload) do
    IO.puts("recurse")
    IO.inspect(field, label: "field")
    IO.inspect(payload, label: "payload")
    IO.inspect(payload, label: "value")
    key = String.to_atom(name)
    value = Map.get(payload, key)

    cond do
      value == nil -> payload
      value == %{} -> Map.put(payload, key, nil)
      true -> Map.put(payload, key, fill(subSchema, value))
    end
  end

  defp reducer(%{name: name, type: "list", subSchema: subSchema} = field, payload) do
    IO.puts("recurse list")
    IO.inspect(field, label: "field")
    IO.inspect(payload, label: "payload")
    key = String.to_atom(name)
    list = Map.get(payload, key)

    cond do
      list == [] ->
        payload

      list == nil ->
        Map.put(payload, key, [])

      true ->
        list_values =
          list
          |> Enum.filter(fn item -> item != %{} && item != nil end)
          |> Enum.map(fn item -> fill(subSchema, item) end)

        Map.put(payload, key, list_values)
    end
  end

  defp reducer(%{name: name} = field, payload) do
    IO.puts("catch all")
    IO.inspect(field, label: "field")
    IO.inspect(payload, label: "payload")

    case Map.has_key?(payload, String.to_atom(name)) do
      true -> payload
      false -> Map.put(payload, String.to_atom(name), nil)
    end
  end
end
