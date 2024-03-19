defmodule DemoWeb.PageLive do
  use DemoWeb, :live_view

  import DemoWeb.DemoComponents 

  def render(assigns) do
    ~H"""
    <.header class="my-4">
      <%= gettext("Welcome to %{name}!", name: "Phoenix LiveView") %>
      <:subtitle>Here you can find some LiveView examples.</:subtitle>
    </.header>

    <ul id="example-list" class="my-2">
      <.example href={~p"/thermostat"} title="Thermostat" description="The simplest example."/>
      <.example href={~p"/snake"} title="Snake" description="The classic game."/>
      <.example href={~p"/search"} title="Search with autocomplete" description="Searches word in /usr/share/dict/words and shows dict command result on submit."/>
      <.example href={~p"/users"} title="CRUD users with live pagination" description="Pagination example. Change page with arrows or click."/>
      <.example href={~p"/users-scroll"} title="Manual infinite scroll with button" description=""/>
      <.example href={~p"/users-auto-scroll"} title="Automatic infinite scroll with JS hook" description=""/>
      <.example href={~p"/image"} title="Image Editor" description=""/>
      <.example href={~p"/clock"} title="Clock" description=""/>
      <.example href={~p"/pacman"} title="Pacman" description=""/>
      <.example href={~p"/rainbow"} title="Rainbow" description=""/>
      <.example href={~p"/top"} title="Top" description=""/>
      <.example href={~p"/presence_users/pippo"} title="Presence Example" description=""/>
      <.example href={~p"/dev/dashboard"} title="Live Dashboard" description="Default Phoenix Dashboard"/>
    </ul>

    <div class="rounded-xl bg-green-100 p-4 my-4">
    <%= live_render(@socket, DemoWeb.WeatherLive, id: :weather) %>
    </div>
    """
  end
end
