defmodule ScamSnareWeb.SignalLive.Index do
  use ScamSnareWeb, :live_view

  alias ScamSnare.Scam
  alias ScamSnare.Scam.Signal

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :signals, Scam.list_signals())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Signal")
    |> assign(:signal, Scam.get_signal!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Signal")
    |> assign(:signal, %Signal{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Signals")
    |> assign(:signal, nil)
  end

  @impl true
  def handle_info({ScamSnareWeb.SignalLive.FormComponent, {:saved, signal}}, socket) do
    {:noreply, stream_insert(socket, :signals, signal)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    signal = Scam.get_signal!(id)
    {:ok, _} = Scam.delete_signal(signal)

    {:noreply, stream_delete(socket, :signals, signal)}
  end
end
