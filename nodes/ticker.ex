defmodule Ticker do

  @interval 2000    # 2 seconds
  @name     :ticker

  def start do
    pid = spawn(__MODULE__, :generator, [[]])
    :global.register_name(@name, pid)
  end

  def register(client_pid) do
    send :global.whereis_name(@name), { :register, client_pid }
  end

  # Send successive ticks to each registered client
  # i.e. the 1st goes to the first, 2nd to the 2nd, ...
  # and after the last client, start from the beginning
  def generator(clients) do
    receive do
      { :register, pid } ->
        IO.puts "registering #{inspect pid}"
        generator([pid|clients])
    after
      @interval ->
        IO.puts "tick"

        # Get the "next" client to send a message, then shift it to the end
        unless Enum.empty? clients do

          [next|tail] = Enum.reverse(clients)

          send next, { :tick }

          generator([next | Enum.reverse(tail)])
        else
          generator(clients)
        end
    end
  end
end

defmodule Client do

  def start do
    pid = spawn(__MODULE__, :receiver, [])
    Ticker.register(pid)
  end

  def receiver do
    receive do
      { :tick } ->
        IO.puts "tock in client"
        receiver()
    end
  end
end
