defmodule DemoWeb.ImageLive do
  use DemoWeb, :live_view

  def radio_tag(assigns) do
    ~H"""
    <input type="radio" id={@value} name={@name} value={@value} checked={@value == @checked} />
    <label for={@value}><%= @label %></label>
    """
  end

  def render(assigns) do
    ~H"""
    <div style={"margin-left: #{@depth * 50}px;"}>
      <form phx-change="update" class="bg-gray-100 roundex-2xl p-2">
        <legend>Choose the <b>size</b> of the phoenix logo</legend>
        <input type="range" min="10" max="630" name="width" value={@width} class="my-2"/>
        <%= @width %>px
        <fieldset>
          <legend class="my-2">and the bg <b>color</b></legend>
          <.radio_tag name={:bg} label="White" value="white" checked={@bg} /><br />
          <.radio_tag name={:bg} label="Black" value="black" checked={@bg} /><br />
          <.radio_tag name={:bg} label="Blue" value="blue" checked={@bg} />
        </fieldset>
      </form>
      <div class="text-sm text-gray-700">Click on the image to raise an exception (boom)</div>
      <div class="my-4">
        <img src={~p"/images/logo.svg"} phx-click="boom" width={@width} style={"background: #{@bg};"} />
      </div>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, assign(socket, width: 100, bg: "white", depth: 0, max_depth: 0)}
  end

  def handle_event("update", %{"width" => width, "bg" => bg}, socket) do
    {:noreply, assign(socket, width: String.to_integer(width), bg: bg)}
  end
end
