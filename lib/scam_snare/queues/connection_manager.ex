defmodule ScamSnare.Queues.ConnectionManager do
  use GenServer
  alias AMQP.{Basic, Connection, Channel, Exchange, Queue}

  @connection Application.compile_env!(:scam_snare, ScamSnare.Queues)[:connection]
  @queue Application.compile_env!(:scam_snare, ScamSnare.Queues)[:queue]
  @exchange Application.compile_env!(:scam_snare, ScamSnare.Queues)[:exchange]

  def start_link(_opts), do: GenServer.start_link(__MODULE__, %{}, name: __MODULE__)

  @impl true
  def init(_) do
    {:ok, conn} = Connection.open(@connection)
    {:ok, channel} = Channel.open(conn)
    setup_queue(channel)

    # Limit unacknowledged messages to 10
    :ok = Basic.qos(channel, prefetch_count: 10)
    # Register the GenServer process as a consumer
    {:ok, _consumer_tag} = Basic.consume(channel, @queue)
    {:ok, channel}
  end

  defp setup_queue(channel) do
    {:ok, _} = Queue.declare(channel, "#{@queue}_error", durable: true)

    # Messages that cannot be delivered to any consumer in the main queue will be routed to the error queue
    {:ok, _} =
      Queue.declare(channel, @queue,
        durable: true,
        arguments: [
          {"x-dead-letter-exchange", :longstr, ""},
          {"x-dead-letter-routing-key", :longstr, "#{@queue}_error"}
        ]
      )

    :ok = Exchange.fanout(channel, @exchange, durable: true)
    :ok = Queue.bind(channel, @queue, @exchange)
  end

  def get_channel, do: GenServer.call(__MODULE__, :get_channel)

  @impl true
  def handle_call(:get_channel, _from, channel), do: {:reply, {:ok, channel}, channel}

  # Confirmation sent by the broker after registering this process as a consumer
  @impl true
  def handle_info({:basic_consume_ok, %{consumer_tag: _consumer_tag}}, chan) do
    {:noreply, chan}
  end

  # Sent by the broker when the consumer is unexpectedly cancelled (such as after a queue deletion)
  @impl true
  def handle_info({:basic_cancel, %{consumer_tag: _consumer_tag}}, chan) do
    {:stop, :normal, chan}
  end

  # Confirmation sent by the broker to the consumer process after a Basic.cancel
  @impl true
  def handle_info({:basic_cancel_ok, %{consumer_tag: _consumer_tag}}, chan) do
    {:noreply, chan}
  end

  @impl true
  def handle_info({:basic_deliver, payload, %{delivery_tag: tag, redelivered: redelivered}}, chan) do
    {:noreply, chan}
  end
end
