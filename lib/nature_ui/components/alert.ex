defmodule NatureUI.Components.Alert do
  alias NatureUi.Tw
  use Phoenix.Component

  defp styles do
    %{
      info: "bg-blue-100 text-blue-800 border border-blue-300",
      success: "bg-green-100 text-green-800 border border-green-300",
      warning: "bg-yellow-100 text-yellow-800 border border-yellow-300",
      error: "bg-red-100 text-red-800 border border-red-300"
    }
  end

  @doc """
  Renders an alert banner with Tailwind defaults.
  - `type`: :info | :success | :warning | :error (default: :info)
  - `class`: custom Tailwind classes to override or extend defaults
  - `rest`: any other attributes
  """
  def alert(assigns) do
    assigns =
      assigns
      |> assign_new(:type, fn -> :info end)
      |> assign_new(:class, fn -> "" end)

    ~H"""
    <div
      class={Tw.merge([
        "rounded-md p-4 flex items-center gap-2",
        styles()[@type],
        @class
      ])}
      {@rest}
    >
      <%= render_slot(@inner_block) %>
    </div>
    """
  end
end
