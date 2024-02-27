defmodule DemoWeb.Router do
  use DemoWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {DemoWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", DemoWeb do
    pipe_through :browser

    live "/", PageLive, :index

    live "/thermostat", ThermostatLive
    live "/search", SearchLive
    live "/clock", ClockLive
    live "/image", ImageLive
    live "/pacman", PacmanLive
    live "/rainbow", RainbowLive
    live "/top", TopLive
    live "/presence_users/:name", UserLive.PresenceIndex

    live "/users/page/:page", UserLive.Index
    live "/users", UserLive.Index, :index
    live "/users-scroll", UserLive.IndexManualScroll, :index
    live "/users-auto-scroll", UserLive.IndexAutoScroll, :index

    live "/users/new", UserLive.New, :new
    live "/users/:id", UserLive.Show, :show
    live "/users/:id/edit", UserLive.Edit, :edit

    #live_session :game, root_layout: {DemoWeb.LayoutView, :game} do
      live "/snake", SnakeLive
    #end
  end

  # Other scopes may use custom stacks.
  # scope "/api", DemoWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:demo, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: DemoWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
