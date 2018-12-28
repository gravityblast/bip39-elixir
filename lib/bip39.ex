defmodule Bip39 do
  alias Bip39.Mnemonic

  defdelegate generate_mnemonic(entropy_size),
    to: Mnemonic,
    as: :generate

  defdelegate validate_mnemonic(mnemonic),
    to: Mnemonic,
    as: :validate
end
