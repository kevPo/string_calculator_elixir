defmodule StringCalculator do
  def add(""), do: 0

  def add(value) do
    extract_delimiters(value)
      |> extract_numbers
      |> convert_strings_to_int
      |> validate_all_are_positive
      |> ignore_numbers_over_1000
      |> sum_values
  end

  defp extract_delimiters(value) do
    case value do
      "//" <> rest -> get_custom_delimiters(rest)
      _ -> [values: value, delimiters: [",", "\n"]]
    end
  end

  defp get_custom_delimiters(value) do
    [delimiters | string] = String.split(value, ["\n"])
    delimiters = String.split(delimiters, ["][", "[", "]"], trim: true)
    [values: Enum.join(string), delimiters: delimiters]
  end

  defp extract_numbers([values: values, delimiters: delimiters]) do
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
