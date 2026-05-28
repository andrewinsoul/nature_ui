defmodule NatureUI.Components.Form do
  use Phoenix.Component
  alias NatureUI.Utils.ClassBuilder

  attr(:for, :any, required: true)
  attr(:as, :any, default: nil)
  attr(:id, :string, default: nil)
  attr(:class, :string, default: nil)
  attr(:error, :string, default: nil)

  attr(:fallback, :string,
    default: "prevent",
    values: ["prevent", "allow"]
  )

  attr(:rest, :global)

  slot(:inner_block, required: true)

  def nature_form(assigns) do
    ~H"""
    <.form
      for={@for}
      as={@as}
      id={@id}
      class={ClassBuilder.build(
        [
          "flex flex-col gap-4",
          @class
        ]
      )}
      data-fallback={@fallback}
      {@rest}
    >
    <p :if={@error} class="text-sm text-red-600" role="alert">
      <%= @error %>
    </p>
      {render_slot(@inner_block)}
    </.form>
    """
  end
end
