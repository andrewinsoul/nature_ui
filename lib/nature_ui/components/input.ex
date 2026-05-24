defmodule NatureUI.Components.Input do
  @moduledoc """
  Form field inputs backed by `%Phoenix.HTML.FormField{}`.

  Use inside [`NatureUI.Components.Form`](NatureUI.Components.Form.html) with a
  `to_form/2` assign:

      <.form for={@form} phx-change="validate" phx-submit="save">
        <.text field={@form[:email]} label="Email" />
      </.form>
  """

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
  attr(:password_toggle, :boolean, default: false)
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
      |> assign(
        :prefix_shell_class,
        ClassBuilder.build(["shrink-0 text-gray-400", assigns.prefix_class])
      )
      |> assign(
        :suffix_shell_class,
        ClassBuilder.build(["shrink-0 text-gray-400", assigns.suffix_class])
      )
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

        <%= if @password_toggle do %>
          <span class={@suffix_shell_class}>
          <button
            type="button"
            id={"#{@field.id}-toggle"}
            phx-hook="NatureUIPasswordToggle"
            data-input-id={@field.id}
            class="focus:outline-none"
          >
            <!-- Eye closed (password hidden) -->
            <span data-eye-closed>
              <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-5 h-5">
                <path stroke-linecap="round" stroke-linejoin="round" d="M3.98 8.223A10.477 10.477 0 001.934 12C3.226 16.338 7.244 19.5 12 19.5c.993 0 1.953-.138 2.863-.395M6.228 6.228A10.45 10.45 0 0112 4.5c4.756 0 8.773 3.162 10.065 7.498a10.523 10.523 0 01-4.293 5.774M6.228 6.228L3 3m3.228 3.228l3.65 3.65m7.894 7.894L21 21m-3.228-3.228l-3.65-3.65" />
              </svg>
            </span>

            <!-- Eye open (password visible) -->
            <span data-eye-open class="hidden">
              <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-5 h-5">
                <path stroke-linecap="round" stroke-linejoin="round" d="M2.036 12.322a1.012 1.012 0 010-.639C3.423 7.51 7.36 4.5 12 4.5c4.638 0 8.573 3.007 9.963 7.178.07.207.07.431 0 .639C20.577 16.49 16.64 19.5 12 19.5c-4.638 0-8.573-3.007-9.963-7.178z" />
                <path stroke-linecap="round" stroke-linejoin="round" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
              </svg>
            </span>
          </button>
          </span>
          <% else %>
          <%= if @suffix_icon do %>
            <span class={@suffix_shell_class}>
              <%= render_slot(@suffix_icon) %>
            </span>
          <% end %>
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

  defp translate_error({msg, opts}) do
    Enum.reduce(opts, msg, fn {key, value}, acc ->
      String.replace(acc, "%{#{key}}", to_string(value))
    end)
  end
end
