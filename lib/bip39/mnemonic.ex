defmodule Bip39.Mnemonic do
  alias Bip39.Mnemonic.{Decoder, Encoder}

  @default_lang :en

  def generate(entropy_size), do: generate(entropy_size, @default_lang)
  def generate(entropy_size, lang) do
    entropy_size
    |> generate_entropy()
    |> Encoder.encode(lang)
  end

  def validate(mnemonic), do: validate(mnemonic, @default_lang)
  def validate(mnemonic, lang) do
    case Decoder.decode(mnemonic, lang) do
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
