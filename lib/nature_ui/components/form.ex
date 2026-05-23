defmodule NatureUI.Components.Form do
  @moduledoc """
  NatureUI form wrapper around [`Phoenix.Component.form/1`](https://hexdocs.pm/phoenix_live_view/Phoenix.Component.html#form/1).

  Use this instead of a plain `<form>` so you get Phoenix form binding (field ids,
  CSRF, LiveView events) plus NatureUI layout and styling.

  ## Setup in a host LiveView

      # mount / handle_event
      assign(socket, :form, to_form(changeset, id: "user"))

      # template
      <.form for={@form} phx-change="validate" phx-submit="save">
        <.text field={@form[:email]} label="Email" />
        <.button type="submit">Save</.button>
      </.form>

  Pass `id` on the form (here via `to_form(..., id: "user")` or `id="user"` on
  `<.form>`) when you need namespaced field ids such as `user_email`.

  ## Global form error

  Use the `error` attribute for a form-level message (for example from
  `action_fallback` or a failed submit):

      <.form for={@form} error={@form_error} phx-submit="save">
        ...
      </.form>
  """
  alias NatureUI.Utils.ClassBuilder
  use Phoenix.Component

  attr(:for, :any,
    required: true,
    doc: "A `%Phoenix.HTML.Form{}`, changeset, or params map. Same as Phoenix."
  )

  attr(:error, :string,
    default: nil,
    doc: "Optional form-level error message shown above the fields."
  )

  attr(:class, :string,
    default: "",
    doc: "Extra Tailwind classes merged with NatureUI defaults on the `<form>` tag."
  )

  attr(:action, :string,
    default: nil,
    doc: "Form action URL. Required for non-LiveView HTTP submissions."
  )

  attr(:as, :atom, default: nil, doc: "Parameter name prefix. Same as Phoenix.")
  attr(:csrf_token, :any, default: nil, doc: "CSRF token override. Same as Phoenix.")
  attr(:errors, :list, default: nil, doc: "Manual errors keyword. Same as Phoenix.")
  attr(:method, :string, default: nil, doc: "HTTP method when `:action` is set.")
  attr(:multipart, :boolean, default: false, doc: "Sets multipart encoding for uploads.")

  attr(:rest, :global,
    doc: "Additional attributes forwarded to Phoenix's form (`id`, `phx-change`, `phx-submit`, etc.)."
  )

  slot(:inner_block, required: true, doc: "Form fields and actions.")

  def form(assigns) do
    rest = form_rest(assigns)

    assigns =
      assigns
      |> assign(:rest, rest)
      |> assign_new(:error, fn -> nil end)
      |> assign_new(:class, fn -> "" end)

    ~H"""
    <Phoenix.Component.form
      for={@for}
      action={@action}
      as={@as}
      csrf_token={@csrf_token}
      errors={@errors}
      method={@method}
      multipart={@multipart}
      {@rest}
    >
      <p :if={@error} class="text-sm text-red-600" role="alert">
        <%= @error %>
      </p>
      {render_slot(@inner_block)}
    </Phoenix.Component.form>
    """
  end

  defp form_rest(assigns) do
    rest = Map.new(assigns.rest)
    rest_class = Map.get(rest, :class) || Map.get(rest, "class")

    form_class =
      ClassBuilder.build([
        "space-y-6",
        assigns.class,
        rest_class
      ])

    rest
    |> Map.delete(:class)
    |> Map.delete("class")
    |> Map.put(:class, form_class)
    |> Map.put(:data_nature_ui, "form")
    |> Enum.to_list()
  end
end
