defmodule StringCalculator do
  def add(value) do
    case value do
      "" -> 0
      _ -> extract_delimiters(value)
      |> extract_numbers
      |> convert_strings_to_int
      |> validate_all_are_positive
      |> ignore_numbers_over_1000
      |> sum_values
    end
  end

  defp extract_delimiters(value) do
    case value do
      "//[" <> rest -> get_custom_delimiters(rest)
      "//" <> rest -> get_custom_delimiters(rest)
      _ -> [values: value, delimiters: [",", "\n"]]
    end
  end

  defp get_custom_delimiters(value) do
    [delimiter | string] = String.split(value, ["]\n", "\n"])
    [values: Enum.join(string), delimiters: delimiter]
  end

  defp extract_numbers([values: values, delimiters: delimiters]) do
    String.split(values, delimiters)
  end

  defp convert_strings_to_int(value) do
    Enum.map(value, &convert_to_int/1)
  end

  defp convert_to_int(value) do
    String.to_integer(value)
  end

  defp validate_all_are_positive(values) do
    case Enum.all?(values, fn x -> x >= 0 end) do
      true -> {:ok, values}
      false -> {:error, "Negatives not allowed"}
    end
  end

  defp ignore_numbers_over_1000({:ok, values}) do
    {:ok, Enum.filter(values, fn x -> x < 1001 end)}
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
