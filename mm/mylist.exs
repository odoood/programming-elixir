defmodule MyList do
  def mapsum([], _f), do: 0
  def mapsum([ head | tail ], f) do
    f.(head) + mapsum(tail, f)
  end

  def max([]), do: nil
  def max([head|tail]) do
    tm = max(tail)
    if tm === nil or head > tm do
      head
    else
      tm
    end
  end

  # Caesar cipher function - works only with lowercase alpha, cause laziness
  def caesar([], _), do: []
  def caesar([head|tail], n) when is_integer(n) and n >= 0
  do
    # IO.puts "#{head}, #{rem(head+n-97,26)+97}"
    if head >= 97 and head <= 97+26 do
      [97 + rem(head + n - 97, 26) | caesar(tail, n)]
    else
      [head | caesar(tail, n)]
    end
  end
end

# MyList.caesar('ryvkve', 13)