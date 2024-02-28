defmodule DemoWeb.DemoComponents do
  use Phoenix.Component

  attr :title, :string, required: true
  attr :href, :string, required: true
  attr :description, :string
  def example(assigns) do
    ~H"""
    <li class="flex shadow-lg px-4 py-2 w-full text-center items-center justify-center hover:bg-gray-50">
      <.link href={@href} class="w-full">
        <h2 class="font-bold my-2"><%= @title %></h2>
        <div class="text-left text-sm text-gray-600">
          <%= @description %>
        </div>
      </.link>
    </li>
    """
  end
end
