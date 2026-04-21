defmodule NatureUI.Static do
  defmacro __using__(_) do
    quote do
      plug(Plug.Static,
        at: "/nature_ui",
        from: {:nature_ui, "priv/static"},
        gzip: false,
        only: ~w(css js)
      )
    end
  end
end
