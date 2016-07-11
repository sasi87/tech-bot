defmodule TechBot.Mixfile do
  use Mix.Project

  def project do
    [app: :tech_bot,
     version: "0.1.0",
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [
      applications: app_list(Mix.env),
      mod: {Bot.Supervisor, []}
    ]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:slack, "~> 0.6.0"},
      {:elixir_wit, "~> 0.1.0"},
      {:dotenv, "~> 2.1"},
      {:websocket_client, git: "https://github.com/jeremyong/websocket_client"}
    ]
  end

  defp app_list(:dev), do: [:dotenv | app_list]
  defp app_list(_), do: app_list
  defp app_list, do: [:logger, :slack, :httpotion]
end
