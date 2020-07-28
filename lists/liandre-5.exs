# ListsAndRecursion-5
defmodule Liandre do
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
end
