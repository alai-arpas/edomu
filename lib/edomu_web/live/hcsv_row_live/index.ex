defmodule EdomuWeb.Hcsv_rowLive.Index do
  use EdomuWeb, :live_view

  alias Edomu.HisPtiAgol
  alias Edomu.HisPtiAgol.HcsvTasks
  alias Edomu.HisPtiAgol.Hcsv_row

  alias Edomu.WhichLiveView

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket) do
      WhichLiveView.set(self())
      IO.inspect(self(), label: "self")
    end

    pti_list = Hcsv_row.grand_pti()
    tasks = HcsvTasks.tasks()
    {pti, task} = {hd(pti_list), hd(tasks)}

    socket = stream(socket, :hcsv_rows, HisPtiAgol.list_by_grand(pti))

    socket =
      assign(socket,
        pti_list: Hcsv_row.grand_pti(),
        tasks: tasks,
        form:
          to_form(%{
            "task" => task,
            "pti" => pti
          }),
        task: task,
        pti: pti,
        directory: Hcsv_row.dir_base(),
        messaggio: "from upload"
      )

    {:ok, socket}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Hcsv row")
    |> assign(:hcsv_row, HisPtiAgol.get_hcsv_row!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Hcsv row")
    |> assign(:hcsv_row, %Hcsv_row{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Hcsv rows")
    |> assign(:hcsv_row, nil)
  end

  @impl true
  def handle_info({:elaboro_file, risposta}, socket) do
    IO.inspect(risposta, label: "elaboro_file")

    {:noreply, assign(socket, messaggio: risposta)}
  end

  @impl true
  def handle_info({EdomuWeb.Hcsv_rowLive.FormComponent, {:saved, hcsv_row}}, socket) do
    {:noreply, stream_insert(socket, :hcsv_rows, hcsv_row)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    hcsv_row = HisPtiAgol.get_hcsv_row!(id)
    {:ok, _} = HisPtiAgol.delete_hcsv_row(hcsv_row)

    {:noreply, stream_delete(socket, :hcsv_rows, hcsv_row)}
  end

  ############################################################
  @impl true
  def handle_event("esegui", _, socket) do
    task = socket.assigns.task
    pti = socket.assigns.pti
    Task.start(fn -> HcsvTasks.esegui_task(task, pti) end)
    {:noreply, stream(socket, :hcsv_rows, HisPtiAgol.list_by_grand(pti), reset: true)}
  end

  def handle_event("cambia-form", %{"task" => task, "pti" => pti} = params, socket) do
    socket = stream(socket, :hcsv_rows, HisPtiAgol.list_by_grand(pti), reset: true)
    socket = assign(socket, task: task, pti: pti)
    IO.inspect(task, label: "task")
    IO.inspect(pti, label: "pti")
    IO.inspect(params, label: "params")
    {:noreply, socket}
  end

  ############
end
