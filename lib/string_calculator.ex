defmodule StringCalculator do
  def add ("") do
    0
  end

  def add(value) do
    String.split(value, [",", "\n"])
    |> Enum.map(&convert_to_int/1)
    |> Enum.sum
  end

  defp convert_to_int(value) do
    Integer.parse((value))
    |> elem(0)
  end
end
