defmodule Bip39.Mnemonic.Encoder do
  alias Bip39.Words
  alias Bip39.Mnemonic.Utils

  defmacrop is_valid_entropy(size) do
    quote do
      unquote(size) >= 128 and unquote(size) <= 256 and rem(unquote(size), 32) == 0
    end
  end

  def encode(entropy, _) when not is_valid_entropy(bit_size(entropy)),
    do: {:error, :invalid_entropy_size}

  def encode(entropy, lang) do
    mnemonic =
      entropy
      |> add_checksum()
      |> split_indexes()
      |> indexes_to_words(lang)
      |> Enum.join(" ")

    {:ok, mnemonic}
  end

  defp add_checksum(entropy) do
    {checksum, size} = Utils.generate_checksum(entropy)
    <<entropy::binary, (<<checksum::size(size)>>)>>
  end

  defp split_indexes(bits), do: split_indexes(bits, [])
  defp split_indexes("", acc), do: acc

  defp split_indexes(<<h::11, t::bitstring>>, acc) do
    split_indexes(t, acc ++ [h])
  end

  defp indexes_to_words(indexes, lang) do
    Enum.map(indexes, &(Words.at(lang, &1)))
  end
end
