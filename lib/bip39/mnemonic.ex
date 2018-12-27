defmodule Bip39.Mnemonic do
  alias Bip39.Words.English

  defmacrop is_valid_entropy(size) do
    quote do
      unquote(size) >= 128 and unquote(size) <= 256 and rem(unquote(size), 32) == 0
    end
  end

  def generate(entropy_size) when not is_valid_entropy(entropy_size),
    do: {:error, :invalid_entropy_size}

  def generate(entropy_size) do
    entropy_size
    |> generate_entropy()
    |> _entropy_to_mnemonic()
  end

  def entropy_to_mnemonic(entropy) when not is_valid_entropy(bit_size(entropy)),
    do: {:error, :invalid_entropy_size}

  def entropy_to_mnemonic(entropy) do
    _entropy_to_mnemonic(entropy)
  end

  defp _entropy_to_mnemonic(entropy) do
    mnemonic =
      entropy
      |> add_checksum()
      |> split_indexes()
      |> indexes_to_words()
      |> Enum.join(" ")

    {:ok, mnemonic}
  end

  def from_random_bytes(_), do: {:error, :invalid_entropy_size}

  defp generate_entropy(size) do
    size
    |> div(8)
    |> :crypto.strong_rand_bytes()
  end

  defp add_checksum(entropy) do
    size =
      entropy
      |> bit_size()
      |> div(32)

    <<cs::size(size), _::bitstring>> = :crypto.hash(:sha256, entropy)
    <<entropy::binary, (<<cs::size(size)>>)>>
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
