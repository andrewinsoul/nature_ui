defmodule NatureUI.Components do
  @moduledoc false

  defmacro __using__(_opts \\ []) do
    quote do
      # use NatureUI
      import NatureUI, only: [scripts: 1]
      import NatureUI.Components.Alert, only: [nature_alert: 1]
      import NatureUI.Components.Button, only: [nature_button: 1]
      import NatureUI.Components.Form, only: [nature_form: 1]
      import NatureUI.Components.Input, only: [nature_text: 1]
      import NatureUI.Components.Modal
    end
  end
end
