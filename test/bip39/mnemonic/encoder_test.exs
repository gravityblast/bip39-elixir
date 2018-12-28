defmodule Bip39.Mnemonic.EncoderTest do
  use ExUnit.Case
  doctest Bip39.Mnemonic.Encoder

  alias Bip39.Mnemonic.Encoder

  import Bip39.TestHelper

  test "encode" do
    Enum.map(vectors(), fn {lang, vectors} ->
      Enum.map(vectors, fn [entr, exp_mnemonic, _, _] ->
        {:ok, mnemonic} =
          entr
          |> String.upcase()
          |> Base.decode16!()
          |> Encoder.encode(String.to_atom(lang))

        assert mnemonic == exp_mnemonic
      end)
    end)
  end

  test "encode validation" do
    for i <- [127, 129, 255, 257] do
      entropy = make_bytes(i)
      assert {:error, :invalid_entropy_size} = Encoder.encode(entropy, :english)
    end

    for i <- [128, 160, 192, 224, 256] do
      entropy = make_bytes(i)
      assert {:ok, _} = Encoder.encode(entropy, :english)
    end
  end
end
