defmodule StringCalculator do
  def add!(""), do: 0
  def add!("//" <> rest), do: get_custom_delimiters(rest) |> add!
  def add!(values) when is_bitstring(values), do: add!({values, [",", "\n"]})
  def add!({values, delimiters}), do: extract_numbers({values, delimiters}) |> add!(0)
  def add!([], accumulator), do: accumulator
  def add!([ head | _ ], _) when head < 0, do: raise "Negatives not allowed"
  def add!([ head | tail ], accumulator) when head > 1000, do: add!(tail, accumulator)
  def add!([ head | tail ], accumulator), do: add!(tail, accumulator + head)

  def extract_numbers({values, delimiters}) do
    String.split(values, delimiters)
    |> Enum.map(&(String.to_integer(&1)))
  end

  defp get_custom_delimiters(value) do
    [delimiters | values] = String.split(value, ["\n"])
    delimiters = String.split(delimiters, ["][", "[", "]"], trim: true)
    {Enum.join(values), delimiters}
  end
end
