import Config

config :esbuild,
  nature_ui: [
    args: ~w(
      src/registry.js
      --bundle
      --target=es2017
      --outfile=priv/static/nature_ui/nature_ui.js
    ),
    cd: Path.expand("../", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]
