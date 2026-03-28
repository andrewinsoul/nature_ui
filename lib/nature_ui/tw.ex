defmodule NatureUi.Tw do
  def merge(classes) when is_list(classes) do
    classes
    |> Enum.filter(& &1)
    |> Enum.join(" ")
    |> TailwindMerge.tw_merge()
  end

  def merge(classes) when is_binary(classes) do
    TailwindMerge.tw_merge(classes)
  end
end
