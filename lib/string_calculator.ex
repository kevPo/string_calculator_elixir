defmodule StringCalculator do
  def add(""), do: 0
  def add("//" <> rest), do: get_custom_delimiters(rest) |> add
  def add({values, delimiters}) do
    extract_numbers(values, delimiters)
    |> convert_strings_to_int
    |> validate_all_are_positive
    |> ignore_numbers_over_1000
    |> sum_values
  end
  def add(values), do: get_default_delimiters(values) |> add

  defp get_custom_delimiters(value) do
    [delimiters | string] = String.split(value, ["\n"])
    delimiters = String.split(delimiters, ["][", "[", "]"], trim: true)
    {Enum.join(string), delimiters}
  end

  def get_default_delimiters(values) do
    {values, [",", "\n"]}
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
