defmodule NatureUI.Components.Input do
  alias NatureUI.Utils.Tw
  alias NatureUI.Utils.Validator
  alias NatureUI.Theme
  alias NatureUI.Utils.ClassBuilder
  use Phoenix.Component

  attr(:field, Phoenix.HTML.FormField, required: true)
  attr(:label, :string, default: nil)
  attr(:type, :string, default: "text")
  attr(:class, :string, default: "")
  attr(:label_class, :string, default: "")
  attr(:size, :atom, default: :md)
  attr(:variant, :atom, default: :default)
  attr(:disabled, :boolean, default: false)

  slot(:prefix_icon)
  slot(:suffix_icon)

  def text(assigns) do
    field = assigns.field
    errors = Enum.map(field.errors, &translate_error/1)
    has_error = Enum.any?(errors)

    validation_rules = Validator.extract_rules(field.form.source, field.field)

    assigns =
      assigns
      |> assign(:errors, errors)
      |> assign(:has_error, has_error)
      |> assign(:rules_json, Jason.encode!(validation_rules))

    input_base_class = "flex items-center rounded-md border px-2 transition"

    assigns =
      assign(
        assigns,
        :input_base_class,
        input_base_class
      )

    input_error_class = "border-red-500"

    assigns =
      assign(
        assigns,
        :input_error_class,
        input_error_class
      )

    input_no_error_class = "border-gray-300 focus-within:border-blue-500"

    assigns =
      assign(
        assigns,
        :input_no_error_class,
        input_no_error_class
      )

    size_class = Theme.size(:input, assigns.size)

    variant =
      cond do
        assigns.has_error -> Theme.variant(:error)
        assigns.disabled -> Theme.variant(:disabled)
        true -> Theme.variant(assigns.variant)
      end

    wrapper_class =
      ClassBuilder.build([
        "flex items-center rounded-md border transition",
        size_class,
        variant,
        assigns.class
      ])

    assigns =
      assign(
        assigns,
        :wrapper_class,
        wrapper_class
      )

    ~H"""
      <div id={"nature-input-#{@field.id}"} class="w-full" phx-hook="NatureInput" data-rules={@rules_json}>
        <%= if @label do %>
          <label class={Tw.merge(["block text-sm mb-1", @label_class])}><%= @label %></label>
        <% end %>

        <div class={@wrapper_class}>
            <%= if @prefix_icon do %>
              <span class="mr-2 text-gray-400">
                <%= render_slot(@prefix_icon) %>
              </span>
            <% end %>

            <input
            type={@type}
            name={@field.name}
            value={@field.value}
            id={@field.id}
            class="flex-1 py-2 outline-none bg-transparent text-black"
            />

            <%= if @suffix_icon do %>
              <span class="ml-2 text-gray-400">
                <%= render_slot(@suffix_icon) %>
              </span>
            <% end %>

        </div>

        <div class="mt-1" data-server-errors>
            <%= for error <- @errors do %>
              <p class="text-red-600 text-xs"><%= error %></p>
            <% end %>
        </div>

        <div class="mt-1 hidden" data-client-error></div>
      </div>
    """
  end

  defp translate_error({msg, _}), do: msg
end
