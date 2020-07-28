# ListsAndRecursion-6
defmodule Liandre do
  #
  # Implement Enum.flatten
  #
  def flatten(nestedList)

  def flatten([]), do: []

  # For when the "head" itself is a list recurse flatten it
  def flatten([head|tail]) when is_list(head) do
    flatten(head) ++ flatten(tail)
  end

  # If the "head" is not a list just recurse the "tail"
  def flatten([head|tail]) do
    [head | flatten(tail)]
  end
end
