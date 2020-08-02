defmodule StrAndBin do
  def is_char_str(chars) when is_list(chars) do
    Enum.all?(chars, &(&1 >= ?\s and &1 <= ?~))
  end
end
