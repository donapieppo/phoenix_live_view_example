defmodule DemoWeb.DemoComponents do
  use Phoenix.Component

  import DemoWeb.CoreComponents

  attr :title, :string, required: true
  attr :href, :string, required: true
  attr :description, :string
  def example(assigns) do
    ~H"""
    <li class="flex border border-gray-300 rounded-2xl my-1 px-4 py-2 w-full items-center justify-center hover:bg-gray-50">
      <.link href={@href} class="w-full">
        <h2 class="font-bold my-2 text-blue-900"><.icon name="hero-chevron-right" class="text-sm" /><%= @title %></h2>
        <div class="text-left text-sm text-gray-500 min-h-3 pl-6">
          <%= @description %>
        </div>
      </.link>
    </li>
    """
  end
end
