# ListsAndRecursion-5
defmodule Liandre do

  # Private function to get the length of list
  defp len([]), do: 0
  defp len([_|tail]) do
    1 + len(tail)
  end

  # Private function to return first n elements of list
  defp get([], _n), do: []
  defp get([_head|_tail], 0), do: []
  defp get([head|tail], n) do
    [head | get(tail, n-1)]
  end

  #
  # Implement Enum.all?
  #
  def all?(list)

  def all?([]), do: true

  # Return immediately on falsy
  def all?([ head | tail ]) do
    if !head do
      false
    else
      all?(tail)
    end
  end

  # Execute function on each item
  def all?([], fun) when is_function(fun), do: true

  def all?([head|tail], fun) when is_function(fun) do
    if !fun.(head) do
      false
    else
      all?(tail, fun)
    end
  end

  #
  # Implement Enum.each
  #
  def each(list, fun)

  def each([], fun) when is_function(fun), do: :ok

  def each([head|tail], fun) when is_function(fun) do
    fun.(head)
    each(tail, fun)
  end

  #
  # Implement Enum.filter
  #
  def filter(list, fun)

  def filter([], fun) when is_function(fun), do: []

  def filter([head|tail], fun) when is_function(fun) do
    if fun.(head) do
      [ head | filter(tail, fun) ]
    else
      filter(tail, fun)
    end
  end

  #
  # Implement Enum.split
  #
  def split(list, count)
  def split(_list, count) when not is_integer(count) do
    raise "Count must be an integer"
  end

  def split(list, count) when count == 0, do: {[], list}

  def split(list, count) when count < 0 do

    l = len(list)
    n = count + l

    if n < 0 do
      {[], list}
    else
      front = get(list, n)
      {front, list -- front}
    end
  end

  def split(list, count) when count > 0 do
    front = get(list, count)
    {front, list -- front}
  end

  #
  # Implement Enum.take
  #
  def take(list, count)

  def take(_list, count) when count == 0, do: []

  def take([head|tail], count) when is_integer(count) and count > 0 do
    # Use the private get
    get([head|tail], count)
  end

  def take([head|tail], count) when is_integer(count) and count < 0 do
    fcount = len([head|tail]) + count

    if fcount <= 0 do
      [head|tail]
    else
      [head|tail] -- get([head|tail], fcount)
    end
  end
end
