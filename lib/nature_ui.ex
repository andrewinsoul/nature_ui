defmodule NatureUI do
  @moduledoc """
  NatureUI component library for Phoenix LiveView.

  ## Setup in a host app

  Create a small module that imports NatureUI components (often alongside
  your own `core_components.ex`):

      defmodule MyAppWeb.NatureUIComponents do
        use NatureUI
      end

  In `MyAppWeb` (or your `html_helpers` macro), import that module:

      def html_helpers do
        quote do
          import MyAppWeb.NatureUIComponents
        end
      end

  ## Forms with Phoenix

  Build a form assign with `Phoenix.Component.to_form/2`, wrap fields in
  `<.form>`, and pass each field struct to NatureUI inputs:

      assign(socket, :form, to_form(changeset, id: "user"))

      <.form for={@form} phx-change="validate" phx-submit="save">
        <.text field={@form[:email]} label="Email" />
        <.button type="submit">Save</.button>
      </.form>

  `NatureUI.Components.Form` delegates to [`Phoenix.Component.form/1`](https://hexdocs.pm/phoenix_live_view/Phoenix.Component.html#form/1),
  so you keep CSRF, LiveView bindings, and `%Phoenix.HTML.FormField{}` access.
  """

  # defmacro __using__(_opts \\ []) do
  #   quote do
  #     import NatureUI, only: [styles: 1, scripts: 1]
  #     import NatureUI.Components.Alert, only: [alert: 1]
  #     import NatureUI.Components.Button, only: [button: 1]
  #     import NatureUI.Components.Form, only: [form: 1]
  #     import NatureUI.Components.Input, only: [text: 1]
  #     import NatureUI.Components.Modal
  #   end
  # end
  defdelegate scripts(assigns), to: NatureUI.Components.Assets
end
