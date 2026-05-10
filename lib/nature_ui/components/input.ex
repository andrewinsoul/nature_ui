defmodule NatureUI.Components.Input do
  alias NatureUI.Utils.Validator
  alias NatureUI.Theme
  alias NatureUI.Utils.ClassBuilder
  use Phoenix.Component

  attr(:field, Phoenix.HTML.FormField, required: true)
  attr(:label, :string, default: nil)
  attr(:type, :string, default: "text")
  attr(:class, :string, default: "")
  attr(:label_class, :string, default: "")
  attr(:input_class, :string, default: "")
  attr(:prefix_class, :string, default: "")
  attr(:suffix_class, :string, default: "")
  attr(:size, :atom, default: :md)
  attr(:variant, :atom, default: :default)
  attr(:disabled, :boolean, default: false)
  attr(:rest, :global)

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
      |> assign(:server_error_id, "#{field.id}-nature-server-errors")

    size_class = Theme.size(:input, assigns.size)

    variant =
      cond do
        assigns.has_error -> Theme.variant(:error)
        assigns.disabled -> Theme.variant(:disabled)
        true -> Theme.variant(assigns.variant)
      end

    wrapper_class =
      ClassBuilder.build([
        "group flex items-center rounded-md border transition shadow-sm focus-within:ring-2 focus-within:ring-offset-0 focus-within:ring-blue-500/40",
        size_class,
        variant,
        assigns.class
      ])

    inner_input_class =
      ClassBuilder.build([
        "flex-1 min-w-0 bg-transparent outline-none placeholder:text-gray-400 text-gray-900 disabled:cursor-not-allowed disabled:opacity-75",
        assigns.input_class
      ])

    assigns =
      assigns
      |> assign(:wrapper_class, wrapper_class)
      |> assign(:inner_input_class, inner_input_class)
      |> assign(:prefix_shell_class, ClassBuilder.build(["shrink-0 text-gray-400", assigns.prefix_class]))
      |> assign(:suffix_shell_class, ClassBuilder.build(["shrink-0 text-gray-400", assigns.suffix_class]))
      |> assign(
        :input_aria_describedby,
        if(has_error, do: assigns.server_error_id, else: nil)
      )

    ~H"""
    <div
      id={"nature-input-#{@field.id}"}
      class="w-full"
      phx-hook="NatureInput"
      data-rules={@rules_json}
    >
      <%= if @label do %>
        <label for={@field.id} class={ClassBuilder.build(["block text-sm font-medium text-gray-700 mb-1", @label_class])}>
          <%= @label %>
        </label>
      <% end %>

      <div class={@wrapper_class}>
        <%= if @prefix_icon do %>
          <span class={@prefix_shell_class}>
            <%= render_slot(@prefix_icon) %>
          </span>
        <% end %>

        <input
          type={@type}
          name={@field.name}
          value={@field.value}
          id={@field.id}
          disabled={@disabled}
          class={@inner_input_class}
          aria-invalid={@has_error}
          aria-describedby={@input_aria_describedby}
          {@rest}
        />

        <%= if @suffix_icon do %>
          <span class={@suffix_shell_class}>
            <%= render_slot(@suffix_icon) %>
          </span>
        <% end %>
      </div>

      <div
        :if={@has_error}
        id={@server_error_id}
        class="mt-1 space-y-0.5"
        data-server-errors
        role="alert"
      >
        <%= for error <- @errors do %>
          <p class="text-red-600 text-xs"><%= error %></p>
        <% end %>
      </div>

      <div class="mt-1 hidden" data-client-error role="alert" aria-live="polite"></div>
    </div>
    """
  end

  defp translate_error({msg, _}), do: msg
end
