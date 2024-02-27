defmodule DemoWeb.PageLive do
  use DemoWeb, :live_view

  def render(assigns) do
    ~H"""
    <section class="phx-hero">
      <h2><%= gettext("Welcome to %{name}!", name: "Phoenix LiveView") %></h2>
      <%= live_render(@socket, DemoWeb.WeatherLive, id: :weather) %>
    </section>

    <section class="row">
      <article class="column">
        <h4>LiveView Examples</h4>
        <ul>
          <li><.link href={~p"/thermostat"}>Thermostat</.link></li>
          <li><.link href={~p"/snake"}>Snake</.link></li>
          <li><.link href={~p"/search"}>Search with autocomplete</.link></li>
          <li><.link href={~p"/users"}>CRUD users with live pagination</.link></li>
          <li><.link href={~p"/users-scroll"}>Manual infinite scroll with button</.link></li>
          <li><.link href={~p"/users-auto-scroll"}>Automatic infinite scroll with JS hook</.link></li>
          <li><.link href={~p"/image"}>Image Editor</.link></li>
          <li><.link href={~p"/clock"}>Clock</.link></li>
          <li><.link href={~p"/pacman"}>Pacman</.link></li>
          <li><.link href={~p"/rainbow"}>Rainbow</.link></li>
          <li><.link href={~p"/top"}>Top</.link></li>
          <li><.link href={~p"/presence_users/pippo"}>Presence Example</.link></li>
          <li><.link href={~p"/dev/dashboard"}>Live Dashboard</.link></li>
        </ul>
      </article>
    </section>
    """
  end
end
