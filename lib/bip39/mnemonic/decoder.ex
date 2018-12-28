defmodule Bip39.Mnemonic.Decoder do
  alias Bip39.Words
  alias Bip39.Mnemonic.Utils

  def decode(mnemonic, lang) when is_binary(mnemonic) do
    with {:ok, words} <- mnemonic_to_words(mnemonic),
         {:ok, indexes} <- words_to_indexes(words, lang),
         {:ok, entropy} <- indexes_to_entropy(indexes) do
      {:ok, entropy}
    end
  end

  defp mnemonic_to_words(mnemonic) do
    case String.split(mnemonic, " ") do
      words when length(words) in [12, 15, 18, 21, 24] ->
        {:ok, words}

      _ ->
        {:error, :invalid_mnemonic_length}
    end
  end

  defp words_to_indexes(words, lang) do
    words_to_indexes(words, lang, [])
  end

  defp words_to_indexes([], _, indexes), do: {:ok, indexes}

  defp words_to_indexes([w | ws], lang, indexes) do
    case Words.find_index(lang, w) do
      nil ->
        {:error, :invalid_word, w}

      index ->
        words_to_indexes(ws, lang, indexes ++ [index])
    end
  end

  defp indexes_to_entropy(indexes) do
    bits = indexes_to_bits(indexes)
    size = bit_size(bits)
    checksum_size = rem(size, 16)
    entropy_size = size - checksum_size

    <<entropy::size(entropy_size), checksum::size(checksum_size)>> = bits

    case Utils.generate_checksum(<<entropy::size(entropy_size)>>) do
      {^checksum, _} ->
        {:ok, <<entropy::size(entropy_size)>>}

      _ ->
        {:error, :invalid_checksum}
    end
  end

  defp indexes_to_bits(indexes) do
    Enum.reduce(indexes, <<>>, fn i, acc ->
      <<acc::bitstring, (<<i::11>>)>>
    end)
  end
end
