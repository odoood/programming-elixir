defmodule StrAndBin do
  def is_char_str(chars) when is_list(chars) do
    Enum.all?(chars, &(&1 >= ?\s and &1 <= ?~))
  end

  # Return true if words are anagrams of each other
  def anagram?(word1, word2) when is_list(word1) and is_list(word2) do
    if ! (is_char_str(word1) and is_char_str(word2)) do
      raise "Both words must be character strings"
    end

    # They must be the same length and have the same chars
    Enum.count(word1) == Enum.count(word2) and word1 -- word2 == []
  end

  # Function to print a list bitstrings centered on the middle of the longest
  def center(list) when is_list(list) do
    if !Enum.all?(list, &(String.printable?(&1))) do
      raise "List can only contain bitstrings"
    end
    maxlen = Enum.max(Enum.map(list, &(String.length(&1))))
    Enum.each list, fn b ->
      len = String.length(b)
      String.pad_leading(b, len + div(maxlen-len, 2)) \
        |> String.pad_trailing(maxlen)
        |> IO.puts
    end
  end
end
