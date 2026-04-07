defmodule NatureUI.Utils.Validator do
  @moduledoc false

  def extract_rules(changeset, field) do
    if ecto_changeset?(changeset) do
      extract_from_changeset(changeset, field)
    else
      default_rules()
    end
  end

  defp extract_from_changeset(changeset, field) do
    validations =
      changeset.validations
      |> Enum.filter(fn {f, _} -> f == field end)
      |> Enum.map(fn {_f, rule} -> rule end)

    %{
      required: field in (changeset.required || []),
      rules:
        validations
        |> Enum.map(&normalize_rule/1)
        |> Enum.reject(&is_nil/1)
    }
  end

  defp default_rules do
    %{
      required: false,
      rules: []
    }
  end


  # ---- Rule Normalization ----

  defp normalize_rule({:length, opts}) do
    %{
      type: "length",
      min: opts[:min],
      max: opts[:max],
      message: opts[:message]
    }
  end

  defp normalize_rule({:format, regex}) do
    %{
      type: "format",
      pattern: Regex.source(regex),
      message: "Invalid format"
    }
  end

  defp normalize_rule({:inclusion, enum}) do
    %{
      type: "inclusion",
      values: enum
    }
  end

  defp normalize_rule({:number, opts}) do
    %{
      type: "number",
      min: opts[:greater_than] || opts[:greater_than_or_equal_to],
      max: opts[:less_than] || opts[:less_than_or_equal_to]
    }
  end

  defp normalize_rule(_), do: nil


  defp ecto_changeset?(%{__struct__: module}) do
    module == Ecto.Changeset
  end

  defp ecto_changeset?(_), do: false
end
