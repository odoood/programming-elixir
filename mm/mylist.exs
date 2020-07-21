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
end
