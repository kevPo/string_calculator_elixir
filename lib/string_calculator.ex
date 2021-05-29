defmodule StringCalculator do
  def add(value) do
    case value do
      "" -> 0
      "//" <> rest -> add_with_custom(rest)
      _ -> add(value, [",", "\n"])
    end
  end

  def add_with_custom(value) do
    [delimiter | string] = String.split(value, "\n")
    add(Enum.join(string), delimiter)
  end

  def add(value, delimiter) do
    String.split(value, delimiter)
    |> Enum.map(&convert_to_int/1)
    |> Enum.sum
  end

  defp convert_to_int(value) do
    String.to_integer(value)
  end
end
