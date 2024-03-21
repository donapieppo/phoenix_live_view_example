defmodule DemoWeb.PageLive do
  use DemoWeb, :live_view

  import DemoWeb.DemoComponents 

  def render(assigns) do
    ~H"""
    <.header class="my-4">
      <%= gettext("Welcome to %{name}!", name: "Phoenix LiveView") %>
      <:subtitle>Here you can find some LiveView examples.</:subtitle>
    </.header>

    <ul id="example-list" class="my-2 max-w-3xl">
      <.example href={~p"/thermostat"} title="Thermostat" description="The simplest example."/>
      <.example href={~p"/snake"} title="Snake" description="The classic game."/>
      <.example href={~p"/pacman"} title="Pacman" description="Another classic game."/>
      <.example href={~p"/search"} title="Search with autocomplete" description="Searches word in /usr/share/dict/words and shows dict command result on submit."/>
      <.example href={~p"/image"} title="Image Editor" description="Modify an image using a form with phx-change."/>
      <.example href={~p"/clock"} title="Clock" description=""/>
      <.example href={~p"/rainbow"} title="Rainbow" description=""/>
      <.example href={~p"/top"} title="Top" description="System top command updated every second."/>
      <.example href={~p"/users"} title="CRUD users with live pagination" description="Pagination example. Change page with arrows or click."/>
      <.example href={~p"/users-scroll"} title="Users with manual infinite scroll with button" description="List of users with `load more` button."/>
      <.example href={~p"/users-auto-scroll"} title="Users with automatic infinite scroll with JS hook" description="List of users without `load more` button."/>
      <.example href={~p"/presence_users/user#{System.unique_integer([:positive])}"} title="Use of presence behaviour" description="Manage users with phoenix presence."/>
      <.example href={~p"/dev/dashboard"} title="Live Dashboard" description="Default Phoenix Dashboard"/>
    </ul>

    <div class="rounded-xl bg-green-100 p-4 my-4">
    <%= live_render(@socket, DemoWeb.WeatherLive, id: :weather) %>
    </div>
    """
  end
end
