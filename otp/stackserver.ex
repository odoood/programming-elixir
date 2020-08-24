defmodule StackServer do
  use GenServer

  # Simplify the stack by reversing the list order
  def init([]),     do: {:ok, []}
  def init([h|t]),  do: {:ok, Enum.reverse([h|t])}

  # Pop a value from the "end" of the stack
  def handle_call(:pop, _from, [tip|rest]) do
    {:reply, tip, rest }
  end

  def handle_cast({:push, new_item}, current_stack) do
    {:noreply, [new_item|current_stack]}
  end
end
