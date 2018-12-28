defmodule Bip39.Mnemonic.EncoderTest do
  use ExUnit.Case
  doctest Bip39.Mnemonic.Encoder

  alias Bip39.Mnemonic.Encoder

  test "encode" do
    Enum.map(get_in(vectors(), ["english"]), fn [entr, exp_mnemonic, _, _] ->
      {:ok, mnemonic} =
        entr
        |> String.upcase()
        |> Base.decode16!()
        |> Encoder.encode()

      assert mnemonic == exp_mnemonic
    end)
  end

  test "encode validation" do
    for i <- [127, 129, 255, 257] do
      entropy = make_bytes(i)
      assert {:error, :invalid_entropy_size} = Encoder.encode(entropy)
    end

    for i <- [128, 160, 192, 224, 256] do
      entropy = make_bytes(i)
      assert {:ok, _} = Encoder.encode(entropy)
    end
  end

  defp vectors do
    "./test/assets/test_vectors.json"
    |> File.read!()
    |> Poison.decode!()
  end

  defp make_bytes(size) do
    Enum.reduce(0..(size - 1), <<>>, fn _, b -> <<(<<b::bitstring>>), (<<0::1>>)>> end)
  end
end
