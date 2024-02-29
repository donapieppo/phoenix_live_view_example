defmodule DemoWeb.UserLive.Live do
  use DemoWeb, :live_component

  defmodule Email do
    use DemoWeb, :live_component

    def mount(socket) do
      {:ok, assign(socket, count: 0)}
    end

    def render(assigns) do
      ~H"""
      <span id={@id} phx-click="click" phx-target={@myself}>
        <strong>Email</strong> <small>(click me)</small> <%= @email %> <%= @count %>
      </span>
      """
    end

    def handle_event("click", _, socket) do
      {:noreply, update(socket, :count, &(&1 + 1))}
    end
  end

  def mount(socket) do
    {:ok, assign(socket, count: 0)}
  end

  def render(assigns) do
    ~H"""
    <div class="user-row flex" id={@id} phx-click="click" phx-target={@myself}>
      <div class="flex-grow">
        <strong><%= @user.username %></strong> <small>(click me)</small> <%= @count %>
      </div>
      <div>
        <.live_component module={Email} id={"email-#{@id}"} email={@user.email} />
      </div>
    </div>
    """
  end

  def handle_event("click", _, socket) do
    {:noreply, update(socket, :count, &(&1 + 1))}
  end
end

defmodule DemoWeb.UserLive.IndexAutoScroll do
  use DemoWeb, :live_view

  alias DemoWeb.UserLive.Live

  def render(assigns) do
    ~H"""
    <div class="relative">
      <.header class="sticky top-0 bg-white my-4">
        Listing Users
        <:subtitle>loaded page <span class="inline-flex items-center rounded-md bg-blue-50 px-2 py-1 text-xs font-medium text-blue-700 ring-1 ring-inset ring-blue-700/10"><%= @page %></span></:subtitle>
      </.header>

      <div id="users" phx-update="stream" phx-hook="InfiniteScroll" data-page={@page}>
        <%= for {dom_id, user} <- @streams.users do %>
          <.live_component module={Live} id={dom_id} user={user} />
        <% end %>
      </div>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(page: 1, per_page: 30)
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
