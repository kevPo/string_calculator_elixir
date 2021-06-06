defmodule StringCalculator do
  def add!(""), do: 0
  def add!("//" <> rest), do: add_with_custom_delimiters(rest)
  def add!(values) when is_bitstring(values), do: add_with_default_delimiters(values)
  def add!([], accumulator), do: accumulator
  def add!([ head | _ ], _) when head < 0, do: raise "Negatives not allowed"
  def add!([ head | tail ], accumulator) when head > 1000, do: add!(tail, accumulator)
  def add!([ head | tail ], accumulator), do: add!(tail, accumulator + head)

  def extract_numbers({values, delimiters}) do
    String.split(values, delimiters)
    |> Enum.map(&(String.to_integer(&1)))
  end

  defp add_with_default_delimiters(values) do
    {values, [",", "\n"]}
    |> extract_numbers
    |> add!(0)
  end

  defp add_with_custom_delimiters(value) do
    [delimiters | string] = String.split(value, ["\n"])
    delimiters = String.split(delimiters, ["][", "[", "]"], trim: true)
    {Enum.join(string), delimiters}
    |> extract_numbers
    |> add!(0)
  end
end
