defmodule NatureUi.Tw do
  def merge(classes) do
    TailwindMerge.merge(classes, TailwindMerge.ClassGroup)
  end
end
