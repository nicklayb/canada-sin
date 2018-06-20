defmodule CanadaSin.MixProject do
  use Mix.Project

  def project do
    [
      app: :canada_sin,
      version: "0.1.0",
      name: "CanadaSin",
      description: "Elixir package that validates a Canadian SIN and can get the SIN's province",
      source_url: "https://github.com/nicklayb/canada_sin",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [coveralls: :test, "coveralls.detail": :test]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp package do
    [
      maintainers: ["Nicolas Boisvert"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/nicklayb/canada_sin"}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, "~> 0.16", only: :dev, runtime: false},
      {:credo, "~> 0.9.1", only: [:dev, :test], runtime: false},
      {:excoveralls, "~> 0.8", only: :test},
      {:mix_test_watch, "~> 0.6", only: :dev, runtime: false}
    ]
  end
end
