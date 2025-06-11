defmodule ScamSnareWeb.ScanRequestLive.Show do
  use ScamSnareWeb, :live_view

  alias ScamSnare.Scans

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:scan_request, Scans.get_scan_request!(id))}
  end

  defp page_title(:show), do: "Show Scan request"
  defp page_title(:edit), do: "Edit Scan request"
end
