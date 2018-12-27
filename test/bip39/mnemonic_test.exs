defmodule Bip39.MnemonicTest do
  use ExUnit.Case
  doctest Bip39.Mnemonic

  alias Bip39.Mnemonic

  test "entropy_to_mnemonic" do
    Enum.map(get_in(vectors(), ["english"]), fn [entr, exp_mnemonic, _, _] ->
      {:ok, mnemonic} =
        entr
        |> String.upcase()
        |> Base.decode16!()
        |> Mnemonic.entropy_to_mnemonic()

      assert mnemonic == exp_mnemonic
    end)
  end

  defp vectors do
    "./test/assets/test_vectors.json"
    |> File.read!()
    |> Poison.decode!()
  end
end
