defmodule DemoWeb.UserLive.Show do
  use DemoWeb, :live_view

  alias Demo.Accounts
  alias Phoenix.LiveView.Socket

  def render(assigns) do
    ~H"""
    <.header>Show User</.header>
    <ul class="my-4">
      <li><b>Username:</b> <%= @user.username %></li>
      <li><b>Email:</b> <%= @user.email %></li>
      <li><b>Phone:</b> <%= @user.phone_number %></li>
    </ul>
    <.link patch={~p"/users/#{@user.id}/edit"}><.button>Edit</.button></.link>
    <.back navigate={~p"/users"}>Back</.back>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def handle_params(%{"id" => id}, _url, socket) do
    if connected?(socket), do: Accounts.subscribe(id)
    {:noreply, socket |> assign(id: id) |> fetch()}
  end

  defp fetch(%Socket{assigns: %{id: id}} = socket) do
    assign(socket, user: Accounts.get_user!(id))
  end

  def handle_info({Accounts, [:user, :updated], _}, socket) do
    {:noreply, fetch(socket)}
  end

  def handle_info({Accounts, [:user, :deleted], _}, socket) do
    {:noreply,
     socket
     |> put_flash(:error, "This user has been deleted from the system")
     |> push_redirect(to: ~p"/users")}
  end
end
