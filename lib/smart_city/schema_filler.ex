defmodule SmartCity.SchemaFiller do
  def fill(payload, schema) do
    Enum.reduce(schema, payload, &reducer/2)
  end

  defp reducer(%{name: name, type: "map"} = field, payload) do
    fill(field, payload)
  end

  defp reducer(schema, payload) when payload == %{} do
    # generate nils all the way down
    nil
  end

  defp reducer(schema, nil) do
    # generate nils all the way down
    nil
  end

  defp reducer(field, payload) do
    IO.inspect(field, label: "field")
    payload
  end
end
