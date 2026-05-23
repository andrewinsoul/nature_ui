defmodule NatureUITest do
  use ExUnit.Case, async: true

  test "use NatureUI imports form and text components" do
    {:module, _} = Code.ensure_compiled(NatureUI)
    {:module, _} = Code.ensure_compiled(NatureUI.Components.Form)
    {:module, _} = Code.ensure_compiled(NatureUI.Components.Input)
  end
end
