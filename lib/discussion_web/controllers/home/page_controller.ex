defmodule DiscussionWeb.PageController do
  use DiscussionWeb, :controller

  def index(conn, _params) do
    # IO.inspect(conn)
    #  assigns: %{current_user: nil, flash: %{}, locale: "en"},
    render(conn, :index)
  end
end
