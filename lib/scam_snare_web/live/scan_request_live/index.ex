defmodule ScamSnareWeb.ScanRequestLive.Index do
  use ScamSnareWeb, :live_view

  alias Phoenix.PubSub
  alias ScamSnare.Scans
  alias ScamSnare.Scans.ScamCheck

  @impl true
  def mount(_params, _session, socket) do
    PubSub.subscribe(ScamSnare.PubSub, "scam_request")

    {:ok,
     socket
     |> assign(:form, to_form(Map.from_struct(%ScamCheck{})))
     |> assign(:debug, "tthis is debug info")
     |> stream(:scan_requests, [])}
  end

  @impl true
  def handle_event("scam_check", params, socket) do
    Phoenix.PubSub.broadcast(
      ScamSnare.PubSub,
      "scam_request",
      {:update, Map.get(params, "content", "empty content")}
    )

    {:noreply, socket}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, socket}
  end

  @impl true
  def handle_info({:update, state}, socket) do
    {:noreply, socket |> assign(:debug, state)}
  end

  @impl true
  def handle_info({ScamSnareWeb.ScanRequestLive.FormComponent, {:saved, scan_request}}, socket) do
    {:noreply, stream_insert(socket, :scan_requests, scan_request)}
  end
end
