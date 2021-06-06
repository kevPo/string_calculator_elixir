defmodule StringCalculatorTest do
  use ExUnit.Case
  doctest StringCalculator

  test "empty string returns 0" do
    assert StringCalculator.add("") == 0
  end

  test "given 1 returns 1" do
    assert StringCalculator.add("1") == 1
  end

  test "1,2 returns 3" do
    assert StringCalculator.add("1,2") == 3
  end

  test "multiple numbers are handled" do
    assert StringCalculator.add("3,3,3") == 9
  end

  test "new lines can be used" do
    assert StringCalculator.add("3\n3,3") == 9
  end

  test "accepts custom delimeters" do
    assert StringCalculator.add("//;\n1;2") == 3
  end

  assert_raise RuntimeError, ~r/^Negatives not allowed/, fn ->
    StringCalculator.add("1,-2")
  end

  test "numbers larger than 1000 are ignored" do
    assert StringCalculator.add("1001,2") == 2
  end

  test "delimiters can be any length" do
    assert StringCalculator.add("//[***]\n1***2***3") == 6
  end

  test "multiple custom delimiters" do
    assert StringCalculator.add("//[*][%]\n1*2%3") == 6
  end

  test "multiple custom delimiters with various length" do
    assert StringCalculator.add("//[***][%]\n1***2%3") == 6
  end
end
