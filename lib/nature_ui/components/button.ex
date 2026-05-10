defmodule NatureUI.Components.Button do
  alias NatureUI.Utils.ClassBuilder
  use Phoenix.Component

  defp variants do
    %{
      primary: "bg-green-600 text-white hover:bg-green-700",
      secondary: "bg-gray-200 text-gray-800 hover:bg-gray-300",
      danger: "bg-red-600 text-white hover:bg-red-700"
    }
  end

  @doc """
  Renders a button with Tailwind defaults.
  - `variant`: :primary | :secondary | :danger (default: :primary)
  - `class`: custom Tailwind classes to override or extend defaults
  - `rest`: any other attributes (phx-click, type, etc.)
  """
  attr(:type, :string, default: "button")
  attr(:class, :string, default: "")
  attr(:fallback, :string, default: nil)
  attr(:target, :string, default: nil)
  attr(:action, :string, default: nil)
  attr(:rest, :global)

  slot(:inner_block, required: true)

  def button(assigns) do
    assigns =
      assigns
      |> assign_new(:variant, fn -> :primary end)
      |> assign_new(:class, fn -> "" end)

    ~H"""
    <button
      type={@type}
      phx-hook="NatureButton"
      data-nui-fallback={@fallback}
      data-target={@target}
      data-action={@action}
      class={ClassBuilder.build([
        "px-4 py-2 rounded font-medium transition",
         variants()[@variant],
         @class
      ])}
      {@rest}
    >
      <%= render_slot(@inner_block) %>
    </button>
    """
  end
end
