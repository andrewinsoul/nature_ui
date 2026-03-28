defmodule NatureUI.Components.Form do
  alias NatureUi.Tw
  use Phoenix.Component

  @doc """
  A wrapper for grouping inputs into a form.

  Props:
  - `error`: optional global error message for the form
  - `class`: custom Tailwind classes for the form container
  - `rest`: other attributes (action, method, phx-submit, etc.)
  - `inner_block`: slot for child inputs/components
  """
  slot(:inner_block)

  def form(assigns) do
    assigns =
      assigns
      |> assign_new(:error, fn -> nil end)
      |> assign_new(:class, fn -> "" end)

    ~H"""
    <form
      data-nature-ui="form"
      class={Tw.merge([
        "space-y-6",
        @class
      ])}
      {@rest}
    >
      <%= render_slot(@inner_block) %>

      <%= if @error do %>
        <p class="text-sm text-red-600 mt-2"><%= @error %></p>
      <% end %>

    </form>
    """
  end
end
