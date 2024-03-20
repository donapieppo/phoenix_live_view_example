defmodule DemoWeb.TopLive do
  use DemoWeb, :live_view

  def render(assigns) do
    ~H"""
    <pre class="bg-gray-100 p-2 rounded-xl mx-2">
      <%= @top %>
    </pre>
    """
  end

  def mount(_params, _session, socket) do
    if connected?(socket), do: :timer.send_interval(1000, self(), :tick)

    {:ok, put_top(socket)}
  end

  def handle_info(:tick, socket) do
    {:noreply, put_top(socket)}
  end

  defp put_top(socket) do
    case :os.type() do
      {:unix, :darwin} ->
        {top, 0} = System.cmd("top", ["-l", "1"])
        assign(socket, top: top)
      {:unix, :linux} ->
        {top, 0} = System.cmd("top", ["-n", "1", "-b"])
        assign(socket, top: top)
    end
  end
end
