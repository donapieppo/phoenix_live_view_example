defmodule DemoWeb.UserLive.Index do
  use DemoWeb, :live_view

  alias Demo.Accounts

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket), do: Accounts.subscribe()
    {:ok, socket |> assign(page: 1, per_page: 10)}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {page, ""} = Integer.parse(params["page"] || "1")
    {:noreply, socket |> assign(page: page) |> fetch()}
  end

  defp fetch(socket) do
    %{page: page, per_page: per_page} = socket.assigns
    socket 
    |> stream(:users, Accounts.list_users(page, per_page), reset: true)
    |> assign(page_title: "Listing Users – Page #{page}")
  end

  @impl true
  def handle_info({Accounts, [:user | _], _}, socket) do
    {:noreply, fetch(socket)}
  end

  @impl true
  def handle_event("keydown", %{"key" => "ArrowLeft"}, socket) do
    {:noreply, go_page(socket, socket.assigns.page - 1)}
  end
  def handle_event("keydown", %{"key" => "ArrowRight"}, socket) do
    {:noreply, go_page(socket, socket.assigns.page + 1)}
  end
  def handle_event("keydown", _, socket), do: {:noreply, socket}
  def handle_event("delete_user", %{"id" => id}, socket) do
    user = Accounts.get_user!(id)
    {:ok, _user} = Accounts.delete_user(user)

    {:noreply, socket |> put_flash(:info, "User deleted")}
  end

  defp go_page(socket, page) when page > 0 do
    push_patch(socket, to: ~p"/users/page/#{page}")
  end
  defp go_page(socket, _page), do: socket
end
