# ListsAndRecursion-5
defmodule Liandre do
  # Implement Enum.all?
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
end
