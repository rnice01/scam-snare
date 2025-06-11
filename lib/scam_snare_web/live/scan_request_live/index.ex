defmodule ScamSnareWeb.ScanRequestLive.Index do
  use ScamSnareWeb, :live_view

  alias ScamSnare.Scans
  alias ScamSnare.Scans.ScanRequest

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :scan_requests, [])}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Scan request")
    |> assign(:scan_request, %ScanRequest{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Scan requests")
    |> assign(:scan_request, nil)
  end

  @impl true
  def handle_info({ScamSnareWeb.ScanRequestLive.FormComponent, {:saved, scan_request}}, socket) do
    {:noreply, stream_insert(socket, :scan_requests, scan_request)}
  end
end
