defmodule MyAppWeb.ItemLive.Index do
  use MyAppWeb, :live_view

  alias MyApp.TodoList
  alias MyApp.TodoList.Item

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :items, TodoList.list_items())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Item")
    |> assign(:item, TodoList.get_item!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Item")
    |> assign(:item, %Item{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Items")
    |> assign(:item, nil)
  end

  @impl true
  def handle_info({MyAppWeb.ItemLive.FormComponent, {:saved, item}}, socket) do
    {:noreply, stream_insert(socket, :items, item)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    item = TodoList.get_item!(id)
    {:ok, _} = TodoList.delete_item(item)

    {:noreply, stream_delete(socket, :items, item)}
  end

  def handle_event("toggle", %{"id" => id}, socket) do
    item = TodoList.get_item!(id)
    {:ok, _} = TodoList.change_item(item)
  end
end
