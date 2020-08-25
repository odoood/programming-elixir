defmodule StackServer do
  use GenServer

  @name :stack

  #####
  # External API
  ####
  def start_link(current_stack) do
    GenServer.start_link(__MODULE__, current_stack, name: @name)
  end

  def pop do
    GenServer.call @name, :pop
  end

  def push(item) do
    GenServer.cast @name, {:push, item}
  end

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

  def terminate(reason, state) do
    IO.puts "**Server terminating, the reason:\n#{inspect reason, pretty: true}"
    IO.puts "**Server terminating, the state:\n#{inspect state}"
  end
end
