defmodule EdomuWeb.Router do
  use EdomuWeb, :router

  import EdomuWeb.UserAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {EdomuWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", EdomuWeb do
    pipe_through [:browser, :require_authenticated_user]

    live_session :authenticated,
      on_mount: {EdomuWeb.UserAuth, :ensure_authenticated} do
      live "/markdown", Markdown.MdLive

      # SERVIZIO IDROGRAFICO
      live "/pti", Pti.PtiLive
      live "/xga", Xga.XgaLive
      live "/xga_copia", Xga.XgaCopiaLive
      live "/servizio_idrografico", Idrografico.IdroLive

      # HIS CENTRAL ESRI AGOL
      live "/hcsv_rows", Hcsv_rowLive.Index, :index
      live "/hcsv_rows/new", Hcsv_rowLive.Index, :new
      live "/hcsv_rows/:id/edit", Hcsv_rowLive.Index, :edit

      live "/hcsv_rows/:id", Hcsv_rowLive.Show, :show
      live "/hcsv_rows/:id/show/edit", Hcsv_rowLive.Show, :edit

      live "/hcsv_jobs", Hcsv_jobLive.Index, :index
      live "/hcsv_jobs/new", Hcsv_jobLive.Index, :new
      live "/hcsv_jobs/:id/edit", Hcsv_jobLive.Index, :edit

      live "/hcsv_jobs/:id", Hcsv_jobLive.Show, :show
      live "/hcsv_jobs/:id/show/edit", Hcsv_jobLive.Show, :edit

      # CARG
      live "/carg", Carg.CargLive
      live "/carg/:foglio", Carg.CargLive

      live "/carg_campioni", CargCampioneLive.Index, :index
      live "/carg_campioni/new", CargCampioneLive.Index, :new
      live "/carg_campioni/:id/edit", CargCampioneLive.Index, :edit

      live "/carg_campioni/:id", CargCampioneLive.Index, :index
      live "/carg_campioni/:id/show/edit", CargCampioneLive.Show, :edit

      # SENSORE CAE STAZIONE E GRAND_SASSARI
      live "/cae_ss_grand", CaeSsGrandLive.Index, :index
      live "/cae_ss_grand/new", CaeSsGrandLive.Index, :new
      live "/cae_ss_grand/:id/edit", CaeSsGrandLive.Index, :edit

      live "/cae_ss_grand/:id", CaeSsGrandLive.Show, :show
      live "/cae_ss_grand/:id/show/edit", CaeSsGrandLive.Show, :edit

      # TRASCODIFICA STAZIONI CAE -> SASSARI
      live "/stazioni_trascodifica", StazioneCodiciLive.Index, :index
      live "/stazioni_trascodifica/new", StazioneCodiciLive.Index, :new
      live "/stazioni_trascodifica/:id/edit", StazioneCodiciLive.Index, :edit

      live "/stazioni_trascodifica/:id", StazioneCodiciLive.Show, :show
      live "/stazioni_trascodifica/:id/show/edit", StazioneCodiciLive.Show, :edit
    end
  end

  scope "/", EdomuWeb do
    pipe_through :browser

    get "/", PageController, :home

    # WEB LINK GESTITI DA DB
    live "/wlinks", WlinkLive.Index, :index
    live "/wlinks/new", WlinkLive.Index, :new
    live "/wlinks/:id/edit", WlinkLive.Index, :edit

    live "/wlinks/:id", WlinkLive.Show, :show
    live "/wlinks/:id/show/edit", WlinkLive.Show, :edit
  end

  # Other scopes may use custom stacks.
  # scope "/api", EdomuWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:edomu, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: EdomuWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end

  ## Authentication routes

  scope "/", EdomuWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated]

    live_session :redirect_if_user_is_authenticated,
      on_mount: [{EdomuWeb.UserAuth, :redirect_if_user_is_authenticated}] do
      live "/users/register", UserRegistrationLive, :new
      live "/users/log_in", UserLoginLive, :new
      live "/users/reset_password", UserForgotPasswordLive, :new
      live "/users/reset_password/:token", UserResetPasswordLive, :edit
    end

    post "/users/log_in", UserSessionController, :create
  end

  scope "/", EdomuWeb do
    pipe_through [:browser, :require_authenticated_user]

    live_session :require_authenticated_user,
      on_mount: [{EdomuWeb.UserAuth, :ensure_authenticated}] do
      live "/users/settings", UserSettingsLive, :edit
      live "/users/settings/confirm_email/:token", UserSettingsLive, :confirm_email
    end
  end

  scope "/", EdomuWeb do
    pipe_through [:browser]

    delete "/users/log_out", UserSessionController, :delete

    live_session :current_user,
      on_mount: [{EdomuWeb.UserAuth, :mount_current_user}] do
      live "/users/confirm/:token", UserConfirmationLive, :edit
      live "/users/confirm", UserConfirmationInstructionsLive, :new
    end
  end
end
