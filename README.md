# Demo

To start your Phoenix server:

  * Run `mix setup` to install and setup dependencies
  * Run `mix run priv/repo/seeds.exs` to populate users in db
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix

## Main changes for phoenix 1.7.11

  * `nimble_strftime` -> `Calendar` in elixir
  * `Routes.static_path` -> `~p"..."`
  * `live_redirect` -> `<.link href={~p"..."}>...</.link>`
  * `link "text", to: "..."` -> `<.link href={~p"...}"}>`
