defmodule ScamSnare.Queues.PublisherBehaviour do
  @callback publish(payload :: binary()) :: :ok | {:error, term()}
end
