defmodule DiscussionWeb.Router do
  use DiscussionWeb, :router

  import DiscussionWeb.UserAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {DiscussionWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
    plug DiscussionWeb.TestingPlugModule.Locale, "en"
  end

  pipeline :is_auth do
    plug :redirect_if_user_is_authenticated
  end

  pipeline :require_auth do
    plug :require_authenticated_user
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", DiscussionWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/hello", HelloController, :index
    get "/hello/:messenger", HelloController, :show

    get "/testing/redirect", HelloController, :redirect_test

    # resources "/hello", HelloController
    # this line is the same as:
    # get /hello HelloController, :index
    # get /hello/:id HelloController, :show

    # get /hello/new HelloController, :new
    # post /hello HelloController, :create

    # get /hello/:id/edit HelloController, :edit
    # patch /hello/:id HelloController, :update
    # put /hello/:id HelloController, :update

    # delete /hello/:id HelloController, :delete
  end

  # Other scopes may use custom stacks.
  # scope "/api", DiscussionWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:discussion, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: DiscussionWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end

  ## Authentication routes

  scope "/", DiscussionWeb do
    # pipe_through [:browser, :redirect_if_user_is_authenticated]
    pipe_through [:browser, :is_auth]

    get "/users/register", UserRegistrationController, :new
    post "/users/register", UserRegistrationController, :create
    get "/users/log_in", UserSessionController, :new
    post "/users/log_in", UserSessionController, :create
    get "/users/reset_password", UserResetPasswordController, :new
    post "/users/reset_password", UserResetPasswordController, :create
    get "/users/reset_password/:token", UserResetPasswordController, :edit
    put "/users/reset_password/:token", UserResetPasswordController, :update
  end

  scope "/", DiscussionWeb do
    # pipe_through [:browser, :require_authenticated_user]
    pipe_through [:browser, :require_auth]

    get "/users/settings", UserSettingsController, :edit
    put "/users/settings", UserSettingsController, :update
    get "/users/settings/confirm_email/:token", UserSettingsController, :confirm_email
  end

  scope "/", DiscussionWeb do
    pipe_through [:browser]

    delete "/users/log_out", UserSessionController, :delete
    get "/users/confirm", UserConfirmationController, :new
    post "/users/confirm", UserConfirmationController, :create
    get "/users/confirm/:token", UserConfirmationController, :edit
    post "/users/confirm/:token", UserConfirmationController, :update
  end
end
