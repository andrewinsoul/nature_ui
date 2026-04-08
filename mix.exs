defmodule NatureUI.MixProject do
  use Mix.Project

  def project do
    [
      app: :nature_ui,
      version: "0.1.0",
      elixir: "~> 1.19",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      package: package(),
      source_url: "https://github.com/andrewinsoul/nature_ui",
      aliases: aliases()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:phoenix, "~> 1.7"},
      {:tails, "~> 0.1.11"},
      {:phoenix_live_view, "~> 1.0.0"},
      # optional if you want Tailwind integration..
      {:tailwind, "~> 0.2", runtime: false},
      # for bundling Svelte JS assets
      {:esbuild, "~> 0.7", runtime: false},
      {:jason, "~> 1.4"}
    ]
  end

  defp aliases do
    [
      "assets.build": [
        "esbuild nature_ui",
        "tailwind nature_ui --minify"
      ]
    ]
  end

  defp description do
    """
    NatureUI is a LiveView component library with an offline-first toggle.
    By default, components use LiveView interactivity, but with `offline: true`
    they load precompiled Svelte assets for offline resilience.
    """
  end

  defp package do
    [
      name: "nature_ui",
      licenses: ["MIT"],
      maintainers: ["Andrew Okoye"],
      links: %{"GitHub" => "https://github.com/andrewinsoul/nature_ui"},
      files: ~w(lib priv/static mix.exs README.md LICENSE)
    ]
  end
end
