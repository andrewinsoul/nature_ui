defmodule NatureUI do
  defdelegate styles(assigns), to: NatureUI.Components.Assets
  defdelegate scripts(assigns), to: NatureUI.Components.Assets
end
