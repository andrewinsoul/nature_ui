defmodule NatureUI do
  defmacro static_plug do
    quote do
      plug(Plug.Static,
        at: "/nature_ui",
        from: {:nature_ui, "priv/static"},
        gzip: false
      )
    end
  end

  defdelegate styles(assigns), to: NatureUI.Components.Assets
end
