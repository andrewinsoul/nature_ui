defmodule NatureUI.Utils.ClassBuilder do
  @moduledoc false
  alias NatureUi.Utils.Tw

  def build(classes) when is_list(classes) do
    classes
    |> Tw.merge()
  end
end
