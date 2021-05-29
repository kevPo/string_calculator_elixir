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
    |> convert_strings_to_int
    |> validate_all_are_positive
    |> ignore_numbers_over_1000
    |> sum_values
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
