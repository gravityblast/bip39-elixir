defmodule Bip39.TestHelper do
  def vectors do
    "./test/assets/test_vectors.json"
    |> File.read!()
    |> Poison.decode!()
  end

  def make_bytes(size) do
    Enum.reduce(0..(size - 1), <<>>, fn _, b -> <<(<<b::bitstring>>), (<<0::1>>)>> end)
  end
end

ExUnit.start()
