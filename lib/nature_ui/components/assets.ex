defmodule NatureUI.Components.Assets do
  use Phoenix.Component

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
