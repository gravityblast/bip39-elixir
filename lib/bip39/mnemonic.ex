defmodule Bip39.Mnemonic do
  alias Bip39.Mnemonic.{Decoder, Encoder}

  def generate(entropy_size) do
    entropy_size
    |> generate_entropy()
    |> Encoder.encode()
  end

  def validate(mnemonic) do
    case Decoder.decode(mnemonic) do
      {:ok, _} -> :ok
      error -> error
    end
  end

  defp generate_entropy(size) do
    size
    |> div(8)
    |> :crypto.strong_rand_bytes()
  end
end
