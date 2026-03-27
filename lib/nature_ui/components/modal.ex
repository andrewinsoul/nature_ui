defmodule NatureUI.Components.Modal do
  use Phoenix.Component

  @doc """
  Renders a modal dialog.
  - `offline`: true | false (default: false)
  - `class`: custom Tailwind classes to override defaults
  - `rest`: any other attributes
  """
  def modal(assigns) do
    assigns =
      assigns
      |> assign_new(:offline, fn -> false end)
      |> assign_new(:class, fn -> "" end)

    ~H"""
    <%= if @offline do %>
      <!-- Offline-ready Svelte mount point -->
      <div
        data-nature-ui="modal-offline"
        class={[
          "fixed inset-0 flex items-center justify-center bg-black bg-opacity-50",
          @class
        ]}
        {@rest}
      >
        <div class="bg-white rounded-lg shadow-lg p-6 w-full max-w-lg">
          <%= render_slot(@inner_block) %>
        </div>
      </div>
      <script src="/nature_ui/nature_ui.js"></script>
    <% else %>
      <!-- LiveView modal -->
      <div
        id="lv-modal"
        class={[
          "fixed inset-0 flex items-center justify-center bg-black bg-opacity-50",
          @class
        ]}
        phx-hook="NatureModal"
        {@rest}
      >
        <div class="bg-white rounded-lg shadow-lg p-6 w-full max-w-lg">
          <%= render_slot(@inner_block) %>
        </div>
      </div>
    <% end %>
    """
  end
end
