defmodule ScamSnare.Queues.ScanPublisher do
  @behaviour ScamSnare.Queues.PublisherBehaviour
  alias ScamSnare.Queues.ConnectionManager
  alias AMQP.Basic

  @exchange Application.compile_env!(:scam_snare, ScamSnare.Queues)[:exchange]

  @impl true
  def publish(payload) do
    with {:ok, channel} <- ConnectionManager.get_channel() do
      :ok = Basic.publish(channel, @exchange, "", payload)
    else
      err -> {:error, err}
    end
  end
end
