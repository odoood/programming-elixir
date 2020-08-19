defmodule Marco do
  def polo(pid) do
    receive do
      token -> send pid, token
    end
  end
end

# play marco polo with 2 processes
p1 = spawn(Marco, :polo, [self()])
p2 = spawn(Marco, :polo, [self()])

send p1, :fred
send p2, :betty

receive do
  token ->
    IO.puts token
end

receive do
  token ->
    IO.puts token
end
