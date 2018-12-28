defmodule Bip39 do
  alias Bip39.Mnemonic

  defdelegate generate_mnemonic(entropy_size, lang),
    to: Mnemonic,
    as: :generate

  defdelegate validate_mnemonic(mnemonic, lang),
    to: Mnemonic,
    as: :validate
end
