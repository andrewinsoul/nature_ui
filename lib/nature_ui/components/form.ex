defmodule NatureUI.Components.Form do
  alias NatureUI.Utils.ClassBuilder
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
      class={ClassBuilder.build([
        "space-y-6",
        @class
      ])}
      {@rest}
    >
    <%= if @error do %>
      <p class="text-sm text-red-600 mt-2"><%= @error %></p>
    <% end %>
      <%= render_slot(@inner_block) %>


    </form>
    """
  end
end
