defmodule Bot do
  use Slack

  def handle_connect(slack, state) do
    IO.puts "Connected as #{slack.me.name}"
    Process.register self, :slack_bot
    {:ok, state}
  end

  def handle_message(message = %{type: "message"}, slack, state) do
    addressed_to_bot = String.contains? message.text, "<@#{slack.me.id}>"
    deployment_channel = Slack.Lookups.lookup_channel_id(System.get_env("DEPLOYMENT_CHANNEL"), slack)
    addressed_in_correct_group = (message.channel == deployment_channel)
    if addressed_to_bot && addressed_in_correct_group do
      NLP.process(message)
    end
    {:ok, state}
  end
  def handle_message(_, _, state), do: {:ok, state}

  def handle_info({:message, message, channel}, slack, state) do
    send_message message, channel, slack
    {:ok, state}
  end
  def handle_info(_, _, _), do: :ok
end
