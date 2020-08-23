defmodule TickerClient do
  @moduledoc """
  Documentation for `TickerClient`.

  The Ticker server & Client modules, consolidated. TickerClient acts as a
  a server and client, and all instances are connected in a ring.

  A particular TickerClient acts as a server for the "next" TickerClient and a
  client for the "previous" TickerClient in the ring (it's both server & client
  for itself where there is a sole TickerClient).
  """
end
