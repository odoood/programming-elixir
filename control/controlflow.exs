# Control Flow exercises
defmodule FizzBuzz do

  # FizzBuzz example using case statement
  def upto(n) when n > 0 do
    1..n |> Enum.map(&fizzbuzz/1)
  end

  defp fizzbuzz(n) do
    case {rem(n, 3), rem(n, 5)} do
    {0, 0} ->
      "FizzBuzz"
    {0, _} ->
      "Fizz"
    {_, 0} ->
      "Buzz"
    {_, _} ->
      n
    end
  end
end

defmodule ControlFlow do
  def ok!({:ok, data}), do: data
  def ok!({code, _}) when is_atom(code), do: raise "Expected :ok, got code :#{code}"
end
