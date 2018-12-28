defmodule Bip39.Words do
  alias Bip39.Words.{
    English,
    Japanese,
    Korean,
    Spanish,
    ChineseSimplified,
    ChineseTraditional,
    French,
    Italian
  }

  @languages [
    english: English,
    japanese: Japanese,
    korean: Korean,
    spanish: Spanish,
    chinese_simplified: ChineseSimplified,
    chinese_traditional: ChineseTraditional,
    french: French,
    italian: Italian
  ]

  for {lang, mod} <- @languages do
    @words mod.words()

    def at(unquote(lang), i), do: Enum.at(@words, i)

    def find_index(unquote(lang), word) do
      Enum.find_index(@words, &(&1 == word))
    end
  end
end
