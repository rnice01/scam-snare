defmodule ScamSnareWeb.SignalLive.FormComponent do
  use ScamSnareWeb, :live_component

  alias ScamSnare.Scam

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage signal records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="signal-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Signal</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{signal: signal} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Scam.change_signal(signal))
     end)}
  end

  @impl true
  def handle_event("validate", %{"signal" => signal_params}, socket) do
    changeset = Scam.change_signal(socket.assigns.signal, signal_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"signal" => signal_params}, socket) do
    save_signal(socket, socket.assigns.action, signal_params)
  end

  defp save_signal(socket, :edit, signal_params) do
    case Scam.update_signal(socket.assigns.signal, signal_params) do
      {:ok, signal} ->
        notify_parent({:saved, signal})

        {:noreply,
         socket
         |> put_flash(:info, "Signal updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_signal(socket, :new, signal_params) do
    case Scam.create_signal(signal_params) do
      {:ok, signal} ->
        notify_parent({:saved, signal})

        {:noreply,
         socket
         |> put_flash(:info, "Signal created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
