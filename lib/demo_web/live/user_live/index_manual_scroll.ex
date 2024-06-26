defmodule DemoWeb.UserLive.IndexManualScroll do
  use DemoWeb, :live_view

  def render(assigns) do
    ~H"""
    <.header>
      Manual infinite scroll with button<:subtitle>page <%= @page %></:subtitle>
    </.header>

    <.table id="users" rows={@streams.users}>
      <:col :let={{_id, user}} label="Username"><%= user.username %></:col>
      <:col :let={{_id, user}} label="Email"><%= user.email %></:col>
    </.table>

    <div id="user_emails2" phx-update="stream">
      <div
        :for={{id, user} <- @streams.users}
        class="inline mx-1 border-2 rounded-xl px-2 bg-blue-600 text-sm text-gray-50"
        id={"#{id}-email"}
      >
        <%= user.email %>
      </div>
    </div>

    <form class="my-4" phx-submit="load-more">
      <.button phx-disable-with="loading...">more</.button>
    </form>
    """
  end

  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(page: 1, per_page: 5, val: 0)
     |> fetch()}
  end

  defp fetch(%{assigns: %{page: page, per_page: per}} = socket) do
    socket
    |> stream(:users, Demo.Accounts.list_users(page, per))
  end

  def handle_event("load-more", _, %{assigns: assigns} = socket) do
    {:noreply,
     socket
     |> assign(page: assigns.page + 1)
     |> fetch()}
  end
end
