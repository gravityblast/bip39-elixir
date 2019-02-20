# Bip39

A [BIP39](https://github.com/bitcoin/bips/blob/master/bip-0039.mediawiki) implementation written in Elixir.

## Example

```elixir
iex(1)> {:ok, mnemonic} = Bip39.generate_mnemonic(128, :english)
{:ok,
 "abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon about"}
iex(2)> Bip39.Mnemonic.validate(mnemonic, :english)
:ok
```
