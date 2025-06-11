defmodule ScamSnareWeb.ScanRequestLive.FormComponent do
  use ScamSnareWeb, :live_component

  alias ScamSnare.Scans

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage scan_request records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="scan_request-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:content]} type="text" label="Content" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Scan request</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{scan_request: scan_request} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Scans.change_scan_request(scan_request))
     end)}
  end

  @impl true
  def handle_event("validate", %{"scan_request" => scan_request_params}, socket) do
    changeset = Scans.change_scan_request(socket.assigns.scan_request, scan_request_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"scan_request" => scan_request_params}, socket) do
    save_scan_request(socket, socket.assigns.action, scan_request_params)
  end

  defp save_scan_request(socket, :edit, scan_request_params) do
    case Scans.update_scan_request(socket.assigns.scan_request, scan_request_params) do
      {:ok, scan_request} ->
        notify_parent({:saved, scan_request})

        {:noreply,
         socket
         |> put_flash(:info, "Scan request updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_scan_request(socket, :new, scan_request_params) do
    case Scans.create_scan_request(scan_request_params) do
      {:ok, scan_request} ->
        notify_parent({:saved, scan_request})

        {:noreply,
         socket
         |> put_flash(:info, "Scan request created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
