defmodule NatureUI.Components.Modal do
  use Phoenix.Component
  alias NatureUi.Tw

  @doc """
  Renders a modal dialog.
  - `class`: custom Tailwind classes to override defaults
  - `rest`: any other attributes
  """
  def modal(assigns) do
    assigns =
      assigns
      |> assign_new(:class, fn -> "" end)

    ~H"""
      <div
        data-nature-ui="modal"
        class={Tw.merge("fixed inset-0 flex items-center justify-center bg-black bg-opacity-50 #{@class}")}
        {@rest}
      >
        <div class="bg-white rounded-lg shadow-lg p-6 w-full max-w-lg">
          <%= render_slot(@inner_block) %>
        </div>
      </div>
    """
  end
end
