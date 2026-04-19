defmodule NatureUI.Components.Assets do
  use Phoenix.Component

  def styles(assigns) do
    ~H"""
    <link
      phx-track-static
      rel="stylesheet"
      href="/nature_ui/css/nature_ui.css"
    />
    """
  end

  def scripts(assigns) do
    ~H"""
    <script
      defer
      phx-track-static
      type="text/javascript"
      src="/nature_ui/js/nature_ui.js">
    </script>
    """
  end
end
