defmodule Bip39.WordsList do
  defmacro __using__(_) do
    quote do
      import unquote(__MODULE__)
    end
  end

  defmacro defwords(words) do
    quote do
      @words unquote(words)

      def words(), do: @words
    end
  end
end
