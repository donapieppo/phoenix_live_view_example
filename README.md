# Demo

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Run `mix setup` to install and setup dependencies. It also runs migration to create users.
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Where to start

Start reading the code from `config/demo_web/router.ex`.

The line
```elixir
  live "/", PageLive, :index
```
defines a LiveView route (see [https://hexdocs.pm/phoenix_live_view/Phoenix.LiveView.Router.html])
to the code in `lib/demo_web/live/page_live.ex`.

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix

## Main changes for phoenix 1.7.11

  * `Routes.static_path` -> `~p"..."`
  * `live_redirect` -> `<.link href={~p"..."}>...</.link>`
  * `link "text", to: "..."` -> `<.link href={~p"...}"}>`
  * streams (`phx-update="append"` is deprecated)
  * `lib/demo_web/templates/layout` is now `lib/demo_web/components/layouts`
  * use of `.simple_form` and `.table from CoreComponents
  * use of Tailwind css with `@apply` directive
  * `NimbleStrftime` -> `Calendar` (merged in elixir)
  *
  * a lot of changes from runnig `mix phx.new demo` :-)

I also moved to sqlite3 as it is just examples.
