defmodule StringCalculator do
  def add!(""), do: 0
  def add!("//" <> rest), do: get_custom_delimiters(rest) |> add!
  def add!(values) when is_bitstring(values), do: get_default_delimiters(values) |> add!
  def add!({values, delimiters}) do
    numbers = String.split(values, delimiters) |> Enum.map(&(String.to_integer(&1)))

    case Enum.any?(numbers, &(&1 < 0)) do
      true -> raise "Negatives not allowed"
      false -> Enum.filter(numbers, &(&1 < 1001)) |> Enum.sum
    end
  end

  defp get_default_delimiters(values), do: {values, [",", "\n"]}
  defp get_custom_delimiters(value) do
    [delimiters | string] = String.split(value, ["\n"])
    delimiters = String.split(delimiters, ["][", "[", "]"], trim: true)
    {Enum.join(string), delimiters}
  end
end
