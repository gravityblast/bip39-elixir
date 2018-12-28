defmodule Bip39.Mnemonic.Utils do
  def generate_checksum(data) do
    size =
      data
      |> bit_size()
      |> div(32)

    <<checksum::size(size), _::bitstring>> = :crypto.hash(:sha256, data)

    {checksum, size}
  end
end
