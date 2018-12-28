defmodule Bip39.Words do
  alias Bip39.Words.{
    English,
    Japanese
  }

  @languages [
    en: English,
    jp: Japanese,
  ]

  for {lang, mod} <- @languages do
    @words mod.words()

    def at(unquote(lang), i), do: Enum.at(@words, i)

    def find_index(unquote(lang), word) do
      Enum.find_index(@words, &(&1 == word))
    end
  end
end
