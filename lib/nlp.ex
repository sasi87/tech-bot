defmodule NLP do
  def process(message) do
    Wit.run_actions(System.get_env("WIT_TOKEN"), nil, DeployAction, message.text, %{channel: message.channel})
  end
end
