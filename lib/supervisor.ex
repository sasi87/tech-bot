defmodule Bot.Supervisor do
  def start(_type, _args) do
    import Supervisor.Spec
    children = [
      worker(Bot, [System.get_env("SLACK_TOKEN"), []])
    ]
    opts = [strategy: :one_for_one]
    Supervisor.start_link(children, opts)
  end
end
