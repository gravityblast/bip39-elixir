defmodule Bip39.Mnemonic.DecoderTest do
  use ExUnit.Case
  doctest Bip39.Mnemonic.Decoder

  alias Bip39.Mnemonic.Decoder

  test "decode validations" do
    assert {:error, :invalid_mnemonic_length} = Decoder.decode("about about", :en)

    invalid_word = "about about about about about about about about about about foo about"
    assert {:error, :invalid_word, "foo"} = Decoder.decode(invalid_word, :en)

    invalid_checksum =
      "abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon"

    assert {:error, :invalid_checksum} = Decoder.decode(invalid_checksum, :en)

    valid_mnemonic =
      "abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon about"

    assert {:ok, _} = Decoder.decode(valid_mnemonic, :en)
  end
end
