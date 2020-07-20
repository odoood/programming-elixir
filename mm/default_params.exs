defmodule Example do
  def func(p1, p2 \\ 2, p3 \\ 3, p4) do
    IO.inspect [p1, p2, p3, p4]
  end
end

Example.func("a", "b")          # => ["a",2,3,"b"]
Example.func("a", "b", "c")     # => ["a",2,3,"b"]
Example.func("a", "b", "c", "d")# => ["a",2,3,"b"]
