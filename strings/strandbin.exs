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
end
