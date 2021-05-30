defmodule StringCalculator do
  def add(""), do: 0
  def add("//" <> rest), do: get_custom_delimiters(rest) |> calculate
  def add(values), do: calculate([values: values, delimiters: [",", "\n"]])

  defp calculate([values: values, delimiters: delimiters]) do
      extract_numbers(values, delimiters)
      |> convert_strings_to_int
      |> validate_all_are_positive
      |> ignore_numbers_over_1000
      |> sum_values
  end

  defp get_custom_delimiters(value) do
    [delimiters | string] = String.split(value, ["\n"])
    delimiters = String.split(delimiters, ["][", "[", "]"], trim: true)
    [values: Enum.join(string), delimiters: delimiters]
  end

  defp extract_numbers(values, delimiters) do
    String.split(values, delimiters)
  end

  defp convert_strings_to_int(value) do
    Enum.map(value, &(String.to_integer(&1)))
  end

  defp validate_all_are_positive(values) do
    case Enum.any?(values, &(&1 < 0)) do
      false -> {:ok, values}
      true -> {:error, "Negatives not allowed"}
    end
  end

  defp ignore_numbers_over_1000({:ok, values}) do
    {:ok, Enum.filter(values, &(&1 < 1001))}
  end

  defp ignore_numbers_over_1000({:error, message}) do
    {:error, message}
  end

  defp sum_values({:ok, values}) do
    Enum.sum(values)
  end

  defp sum_values({:error, message}) do
    {:error, message}
  end
end
