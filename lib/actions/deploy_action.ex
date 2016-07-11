defmodule DeployAction do
  use Wit.Actions
  alias Wit.Models.Response.Converse, as: WitConverse

  def say(_session, %{success: true} = context, %WitConverse{msg: message}) do
    bot_reply message, context.channel
  end
  def say(_session, %{failure: true} = context, %WitConverse{msg: message}) do
    bot_reply message, context.channel
  end

  def error(_session, %{} = _context, error) do
    IO.puts "Error recieved: #{inspect(error)}"
  end

  def merge(_session, %{} = context, %WitConverse{} = message) do
    %WitConverse{entities: %{"environment" => [%{"value" =>  environment} |_], "repository" => [%{"value" => repository} |_]}} = message
    Map.put(context, :environment, environment)
    Map.put(context, :repository, repository)
  end

  defaction deploy(_session, %{} = context) do
    deploy = true
    if deploy do
      Map.put(context, :success, true)
    else
      Map.put(context, :failure, true)
    end
  end

  defaction story_ended(_session, %{} = context) do
    context
  end

  defp bot_reply(message, channel) do
    send :slack_bot, {:message, message, channel}
  end
end
