defmodule DemoWeb.ThermostatLive do
  use DemoWeb, :live_view

  def render(assigns) do
    ~H"""
    <.header>
      Thermostat Example
      <:subtitle>Temperatures over 75 raise <span class="text-red-700">Boom</span></:subtitle>
    </.header>

    <div class="thermostat">
      <div class={"bar #{@mode}"}>
        <a href="#" phx-click="toggle-mode"><%= @mode %></a>
        <span><%= Calendar.strftime(@time, "%H:%M:%S") %></span>
      </div>
      <div class="controls">
        <span class="reading"><%= @val %></span>
        <button phx-click="dec" class="minus">-</button>
        <button phx-click="inc" class="plus">+</button>
        <span class="weather">
          <%= live_render(@socket, DemoWeb.WeatherLive, id: "weather") %>
        </span>
      </div>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    if connected?(socket), do: :timer.send_interval(100, self(), :tick)
    {:ok, assign(socket, val: 72, mode: :cooling, time: NaiveDateTime.local_now())}
  end

  def handle_info(:tick, socket) do
    {:noreply, assign(socket, time: NaiveDateTime.local_now())}
  end

  def handle_event("inc", _, socket) do
    if socket.assigns.val >= 75, do: raise("boom")
    {:noreply, update(socket, :val, &(&1 + 1))}
  end

  def handle_event("dec", _, socket) do
    {:noreply, update(socket, :val, &(&1 - 1))}
  end

  def handle_event("toggle-mode", _, socket) do
    {:noreply,
     update(socket, :mode, fn
       :cooling -> :heating
       :heating -> :cooling
     end)}
  end
end
