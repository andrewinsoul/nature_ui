defmodule NatureUi.Utils.Validator do
  @moduledoc false
  def extract_rules(changeset, field) do
    validations =
      changeset.validations
      |> Enum.filter(fn {f, _} -> f == field end)
      |> Enum.map(fn {_f, rule} -> rule end)

    %{
      required: field in changeset.required,
      rules: Enum.map(validations, &normalize_rule/1)
    }
  end

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

  defp normalize_rule(_), do: nil
end
