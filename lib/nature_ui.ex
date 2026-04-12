defmodule NatureUI do
  defmacro static_plug do
    quote do
      plug(Elixir.Plug.Static,
        at: "/nature_ui",
        from: {:nature_ui, "priv/static"},
        gzip: false
      )
    end
  end
end
