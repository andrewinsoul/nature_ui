import Config

config :esbuild,
  version: "0.25.0",
  nature_ui: [
    args: ~w(
      assets/js/index.js
      --bundle
      --target=es2017
      --outfile=priv/static/js/nature_ui.js
    ),
    cd: Path.expand("../", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

config :tailwind,
  version: "3.4.0",
  nature_ui: [
    args: ~w(
      --config=assets/tailwind.config.js
      -i assets/css/app.css
      -o priv/static/css/nature_ui.css
    ),
    cd: Path.expand("..", __DIR__)
  ]
