defmodule DemoWeb.UserLive.Row do
  use DemoWeb, :live_component

  defmodule Email do
    use DemoWeb, :live_component

    def mount(socket) do
      {:ok, assign(socket, count: 0), temporary_assigns: [email: nil]}
    end

    def render(assigns) do
      ~H"""
      <span id={@id} phx-click="click" phx-target={@myself}>
        Email: <%= @email %> <%= @count %>
      </span>
      """
    end

    def handle_event("click", _, socket) do
      {:noreply, update(socket, :count, &(&1 + 1))}
    end
  end

  def mount(socket) do
    {:ok, assign(socket, count: 0), temporary_assigns: [user: nil]}
  end

  def render(assigns) do
    ~H"""
    <tr class="user-row" id={@id} phx-click="click" phx-target={@myself}>
      <td><%= @user.username %> <%= @count %></td>
      <td>
        <.live_component module={Email} id={"email-#{@id}"} email={@user.email} />
      </td>
    </tr>
    """
  end

  def handle_event("click", _, socket) do
    {:noreply, update(socket, :count, &(&1 + 1))}
  end
end

defmodule DemoWeb.UserLive.IndexAutoScroll do
  use DemoWeb, :live_view

  alias DemoWeb.UserLive.Row

  def render(assigns) do
    ~H"""
    <table>
      <tbody id="users"
             phx-update="stream"
             phx-hook="InfiniteScroll"
             data-page={@page}>
        <%= for {dom_id, user} <- @streams.users do %>
          <.live_component module={Row} id={dom_id} user={user} />
        <% end %>
      </tbody>
    </table>
    """
  end

  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(page: 1, per_page: 10)
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
