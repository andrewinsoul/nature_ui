defmodule NatureUI.Components do
  @moduledoc false

  defmacro __using__(_opts \\ []) do
    quote do
      use NatureUI
    end
  end
end
