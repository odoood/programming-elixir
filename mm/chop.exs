defmodule Chop do
  def guess(actual, range)

  # Actual found
  def guess(actual, low..high) when is_integer(actual)
    and actual == low + div(high - low, 2)
  do
    IO.puts "Is it #{actual}"
    actual
  end

  # Actual is lower than middle
  def guess(actual, low..high) when is_integer(actual)
    and actual >= low and actual <= high
    and actual < low + div(high - low,2)
  do
    middle = low + div(high - low, 2)
    IO.puts "Is it #{middle}"

    # Halve the range and guess again
    guess(actual, low..middle)
  end

  # Actual is higher than middle
  def guess(actual, low..high) when is_integer(actual)
    and actual >= low and actual <= high
    and actual > low + div(high - low,2)
  do
    middle = low + div(high - low, 2)
    IO.puts "Is it #{middle}"

    # Halve the range and guess again
    guess(actual, middle..high)
  end
end

Chop.guess(273, 1..1000)