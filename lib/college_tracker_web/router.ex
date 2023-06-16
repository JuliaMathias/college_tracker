defmodule CollegeTrackerWeb.Router do
  use CollegeTrackerWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {CollegeTrackerWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", CollegeTrackerWeb do
    pipe_through :browser

    get "/", PageController, :home
    live "/activity_categories", ActivityCategoryLive.Index, :index
    live "/activity_categories/new", ActivityCategoryLive.Index, :new
    live "/activity_categories/:id/edit", ActivityCategoryLive.Index, :edit

    live "/activity_categories/:id", ActivityCategoryLive.Show, :show
    live "/activity_categories/:id/show/edit", ActivityCategoryLive.Show, :edit

    live "/activity_types", ActivityTypeLive.Index, :index
    live "/activity_types/new", ActivityTypeLive.Index, :new
    live "/activity_types/:id/edit", ActivityTypeLive.Index, :edit

    live "/activity_types/:id", ActivityTypeLive.Show, :show
    live "/activity_types/:id/show/edit", ActivityTypeLive.Show, :edit
  end

  # Other scopes may use custom stacks.
  # scope "/api", CollegeTrackerWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:college_tracker, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: CollegeTrackerWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
