defmodule SmartCity.SchemaFiller do
  def fill(payload, schema) do
    Enum.reduce(schema, payload, &reducer/2)
  end

  defp reducer(schema, payload) when payload == %{} do
    IO.puts("empty map")
    IO.inspect(field, label: "field")
    IO.inspect(payload, label: "payload")
    nil
  end

  defp reducer(schema, nil) do
    IO.puts("nil payload")
    IO.inspect(field, label: "field")
    IO.inspect(payload, label: "payload")
    nil
  end

  defp reducer(%{name: name, type: "map", subSchema: schema} = field, payload) do
    IO.puts("recurse")
    IO.inspect(field, label: "field")
    IO.inspect(payload, label: "payload")
    fill(schema, payload)
  end

  defp reducer(field, payload) do
    IO.puts("catch all")
    IO.inspect(field, label: "field")
    IO.inspect(payload, label: "payload")
    value = Map.get(payload, field.name)
    IO.inspect(value, label: "value")

    value
  end
end
