defmodule DemoWeb.UserLive.IndexManualScroll do
  use DemoWeb, :live_view

  def render(assigns) do
    ~H"""
    <table>
      <tbody phx-update="stream" id="users">
        <%= for {dom_id, user} <- @streams.users do %>
          <tr class="user-row" id={dom_id}>
            <td><%= user.username %></td>
            <td><%= user.email %></td>
          </tr>
        <% end %>
      </tbody>
    </table>
    <form phx-submit="load-more">
      <button phx-disable-with="loading...">more</button>
    </form>
    """
  end

  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(page: 1, per_page: 10, val: 0)
     |> fetch()}
  end

  defp fetch(%{assigns: %{page: page, per_page: per}} = socket) do
    socket 
    |> stream(:users, Demo.Accounts.list_users(page, per))
  end

  def handle_event("load-more", _, %{assigns: assigns} = socket) do
    {:noreply, socket |> assign(page: assigns.page + 1) |> fetch()}
  end
end
