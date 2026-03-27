defmodule NatureUI.Components.Form do
  use Phoenix.Component

  @doc """
  A wrapper for grouping inputs into a form.

  Props:
  - `offline`: true | false (default: false) — applies offline toggle to all child inputs
  - `error`: optional global error message for the form
  - `class`: custom Tailwind classes for the form container
  - `rest`: other attributes (action, method, phx-submit, etc.)
  - `inner_block`: slot for child inputs/components
  """
  slot :inner_block

  def form(assigns) do
    assigns =
      assigns
      |> assign_new(:offline, fn -> false end)
      |> assign_new(:error, fn -> nil end)
      |> assign_new(:class, fn -> "" end)

    ~H"""
    <form
      data-nature-ui={if @offline, do: "form-offline", else: nil}
      class={[
        "space-y-6",
        @class
      ]}
      {@rest}
    >
      <%= render_slot(@inner_block) %>

      <%= if @error do %>
        <p class="text-sm text-red-600 mt-2"><%= @error %></p>
      <% end %>

      <%= if @offline do %>
        <script src="/nature_ui/nature_ui.js"></script>
      <% end %>
    </form>
    """
  end
end
