defmodule TickerClient do
  @moduledoc """
  Documentation for `TickerClient`.

  The `Ticker` server & `Client` modules, consolidated. `TickerClient` acts as a
  a server and client, and all instances are connected in a ring.

  A particular `TickerClient` acts as server for the "next" `TickerClient` and
  client for the "previous" `TickerClient` in the ring (it's both for itself
  where there is a sole `TickerClient`).
  """

  @interval 2000    # 2 seconds
  @name     :og     # The original client
  @newmsg   {:new}  # Message sent/received for adding a new client


  @doc """
  start.

  Create a new server/client in the ring, attaching it to the "end" of the ring,
  just behind the original (if it exists).
  """
  def start do
    # Register the new client in the ring, with the original PID as a reference
    register(:global.whereis_name @name)
  end

  defp register(:undefined) do
    # This is the first client in the ring so create and register its PID
    pid = spawn(__MODULE__, :ticknext, [self()])
    :global.register_name(@name, pid)
  end

  defp register(pid) do
    # This is not the first, so add a new one to the ring
    send pid, @newmsg
  end

  def ticknext(pid) do

    # Wait for a message from another client
    receive do

      @newmsg ->

        IO.puts "A new client to be added..."

        ticknext(pid)
    end
  end
end
