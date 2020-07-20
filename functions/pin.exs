# Pattern matching pinning in function
defmodule Greeter do
  def for(name, greeting) do
    fn
      (^name) -> "#{greeting} #{name}"
      (_)     -> "I don't know you"
    end
  end
end

mr_valim = Greeter.for("Jose", "Oi!")

IO.puts mr_valim.("Jose")   # => Oi! José
IO.puts mr_valim.("Dave")   # => I don't know you