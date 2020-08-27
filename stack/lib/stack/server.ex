defmodule Stack.Server do
  use GenServer

  #####
  # External API
  ####
  def start_link(_) do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def pop do
    GenServer.call __MODULE__, :pop
  end

  def push(item) do
    GenServer.cast __MODULE__, {:push, item}
  end

  def init(_) do
    {
      :ok,
      Stack.Stash.get()
      |> Enum.reverse
    }
  end

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

    Stack.Stash.set(state)
  end
end
