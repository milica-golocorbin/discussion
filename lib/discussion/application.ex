defmodule Discussion.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      DiscussionWeb.Telemetry,
      # Start the Ecto repository
      Discussion.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Discussion.PubSub},
      # Start Finch
      {Finch, name: Discussion.Finch},
      # Start the Endpoint (http/https)
      DiscussionWeb.Endpoint
      # Start a worker by calling: Discussion.Worker.start_link(arg)
      # {Discussion.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Discussion.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    DiscussionWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
