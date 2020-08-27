defmodule Stack.Stash do
  use GenServer

  @me __MODULE__

  # Simple server to stash a stack

  def start_link(initial_stack) do
    GenServer.start_link(__MODULE__, initial_stack, name: @me)
  end

  def get do
    GenServer.call(@me, { :get })
  end

  def set(stack) do
    GenServer.call(@me, { :set, stack })
  end

  # Server implementation

  def init(initial_stack), do: { :ok, initial_stack }

  def handle_call({ :get }, _from, current_stack) do
    { :reply, current_stack, current_stack }
  end

  def handle_cast({ :set, new_stack }, _current_stack) do
    { :noreply, new_stack }
  end
end
