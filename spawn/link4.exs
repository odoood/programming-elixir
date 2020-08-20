defmodule Link4 do
  import :timer, only: [ sleep: 1 ]

  def pop(pid) do
    # Send some messages to the parent process
    send pid, "One bottle of pop"
    send pid, "Two bottle of pop"
    send pid, "Three bottle of pop"
    send pid, "Four bottle of pop"
    send pid, "Five bottle of pop"
    send pid, "Six bottle of pop"
    send pid, "Seven bottle of pop, pop!"
    # raise "Failure pop..."
    exit(:pop)
  end

  def trace(index) do
    receive do
      msg ->
        IO.puts "Message ##{index}: #{inspect msg}"
        trace(1+index)
    after 1000 ->
      IO.puts "\nEnd of messages."
    end
  end

  def run do
    spawn_link(Link4, :pop, [self()])
    sleep 500
    trace(1)
  end
end

Link4.run
