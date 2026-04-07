defmodule NatureUI.Utils.Tw do
  def merge(classes) when is_list(classes) do
    classes
    |> Enum.filter(& &1)
    |> Enum.flat_map(&split_classes/1)
    |> Tails.merge()
    |> to_string()
  end

  def merge(classes) when is_binary(classes) do
    classes
    |> split_classes()
    |> Tails.merge()
    |> to_string()
  end

  defp split_classes(class) when is_binary(class) do
    String.split(class, ~r/\s+/, trim: true)
  end

  defp split_classes(_), do: []
end
