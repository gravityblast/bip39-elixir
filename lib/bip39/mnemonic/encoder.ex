defmodule Bip39.Mnemonic.Encoder do
  alias Bip39.Words.English
  alias Bip39.Mnemonic.Utils

  defmacrop is_valid_entropy(size) do
    quote do
      unquote(size) >= 128 and unquote(size) <= 256 and rem(unquote(size), 32) == 0
    end
  end

  def encode(entropy) when not is_valid_entropy(bit_size(entropy)),
    do: {:error, :invalid_entropy_size}

  def encode(entropy) do
    mnemonic =
      entropy
      |> add_checksum()
      |> split_indexes()
      |> indexes_to_words()
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

  defp indexes_to_words(indexes) do
    Enum.map(indexes, &English.at/1)
  end
end
