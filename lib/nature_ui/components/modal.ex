defmodule NatureUI.Components.Modal do
  use Phoenix.Component

  alias NatureUI.Theme
  alias NatureUI.Utils.ClassBuilder

  slot(:header)
  slot(:body, required: true)
  slot(:footer)

  attr(:size, :atom, default: :md)
  attr(:animated, :boolean, default: true)

  def modal(assigns) do
    modal_width = Theme.size(:modal, assigns.size)

    container_class =
      ClassBuilder.build([
        Theme.modal(:container),
        modal_width,
        assigns.animated && "transition duration-200"
      ])

    assigns = assign(assigns, :container_class, container_class)

    overlay_class =
      ClassBuilder.build([
        Theme.modal(:overlay),
        assigns.animated && Theme.modal(:hidden_animated),
        !assigns.animated && Theme.modal(:hidden_static)
      ])

    assigns = assign(assigns, :overlay_class, overlay_class)

    modal_class =
      ClassBuilder.build([
        Theme.modal(:wrapper),
        assigns.animated && Theme.modal(:modal_hidden_animated),
        !assigns.animated && Theme.modal(:hidden_static)
      ])

    assigns = assign(assigns, :modal_class, modal_class)

    ~H"""
    <div
      phx-hook="NatureModal"
      id={generate_id()}
      data-animated={@animated}
    >
      <!-- Overlay -->
      <div class={@overlay_class} data-overlay></div>

      <!-- Modal -->
      <div class={@modal_class} data-modal>
        <div class={@container_class}>

          <!-- Header -->
          <%= if @header != [] do %>
            <div class={Theme.modal(:header)}>
              <div><%= render_slot(@header) %></div>

              <button type="button" data-close class="text-gray-400 hover:text-gray-600">
                ✕
              </button>
            </div>
          <% end %>

          <!-- Body -->
          <div class={Theme.modal(:body)}>
            <%= render_slot(@body) %>
          </div>

          <!-- Footer -->
          <%= if @footer != [] do %>
            <div class={Theme.modal(:footer)}>
              <%= render_slot(@footer) %>
            </div>
          <% end %>

        </div>
      </div>
    </div>
    """
  end

  def generate_id(),
    do:
      :crypto.strong_rand_bytes(16)
      |> Base.encode16(case: :lower)
end
