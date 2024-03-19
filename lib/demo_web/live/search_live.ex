defmodule DemoWeb.SearchLive do
  use DemoWeb, :live_view

  def render(assigns) do
    ~H"""
    <.header>
      Search with autocomplete
      <:subtitle>Autocomplete from <i>/usr/share/dict/words</i> and on submit shows dict.</:subtitle>
    </.header>
    <form phx-change="suggest" phx-submit="search" class="my-4">
      <input type="text" name="q" value={@query} list="matches" placeholder="Search..." {%{readonly: @loading}}/>
      <datalist id="matches">
        <option :for={match <- @matches} value={match}><%= match %></option>
      </datalist>
      <pre :if={@result} class="text-sm my-2 p-4 bg-gray-50 rounded"><%= @result %></pre>
    </form>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, assign(socket, query: nil, result: nil, loading: false, matches: [])}
  end

  def handle_event("suggest", %{"q" => query}, socket) when byte_size(query) <= 100 do
    {words, _} = System.cmd("grep", ~w"^#{query}.* -m 5 /usr/share/dict/words")
    {:noreply, assign(socket, matches: String.split(words, "\n"))}
  end

  def handle_event("search", %{"q" => query}, socket) when byte_size(query) <= 100 do
    send(self(), {:search, query})
    {:noreply, assign(socket, query: query, result: "Searching...", loading: true, matches: [])}
  end

  def handle_info({:search, query}, socket) do
    {result, _} = System.cmd("dict", ["#{query}"], stderr_to_stdout: true)
    {:noreply, assign(socket, loading: false, result: result, matches: [])}
  end
end
