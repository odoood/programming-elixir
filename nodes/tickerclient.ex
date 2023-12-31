defmodule TickerClient do
  @moduledoc """
  Documentation for `TickerClient`.

  The `Ticker` server & `Client` modules, consolidated. `TickerClient` acts as a
  a server and client, and all instances are connected in a ring.

  A particular `TickerClient` acts as server for the "next" `TickerClient` and
  client for the "previous" `TickerClient` in the ring (it's both for itself
  where there is a sole `TickerClient`).
  """

  import :global, only: [ whereis_name: 1 ]

  @interval 2000    # 2 seconds
  @name     :og     # The original client
  @newmsg   :new    # Message sent/received for adding a new client
  @tickmsg  :tick   # Message sent/received for ticking a client


  @doc """
  Create a new server/client in the ring, attaching it to the "end" of the ring,
  just behind the original (if it exists).
  """
  def create do
    # Register the new client in the ring, with the original PID as a reference
    register(whereis_name @name)
  end

  defp register(:undefined) do
    # This is the first client in the ring so create and register its PID
    pid = spawn(__MODULE__, :ticknext, [@name])
    :global.register_name(@name, pid)
  end

  defp register(pid) do
    # This is not the first, so add a new one to the ring
    send pid, @newmsg
  end

  @doc """
  Start the ticking (at the first client)
  """
  def start, do: _start(whereis_name @name)

  defp _start(:undefined),  do: raise "No clients exist."
  defp _start(pid),         do: send pid, @tickmsg

  def ticknext(@name) do
    # Takes its name to identify itself as the first client process and
    # calls the ticknext fn with its own pid after receiving any initial message
    IO.puts "First client created: #{inspect self()}"
    ticknext(self())
  end

  def ticknext(pid) do

    # Wait for a message from another client
    receive do

      @tickmsg ->

        IO.puts "tock from client: #{inspect self()}"
        IO.puts "Sending tick to next client: #{inspect pid}"

        # Sleep for the interval then tick the next client
        :timer.sleep @interval
        send pid, @tickmsg

        ticknext(pid)

      @newmsg ->

        # For the client before the first, add a new client process to the end
        # and set the target of the new process to the first--for all others,
        # pass the message to the next client
        opid = whereis_name(@name)

        if pid === opid do

          newpid = spawn(__MODULE__, :ticknext, [opid])

          IO.puts "Adding new client: #{inspect newpid}"

          ticknext(newpid)

        else

          send pid, @newmsg

          ticknext(pid)
        end
    end
  end
end
