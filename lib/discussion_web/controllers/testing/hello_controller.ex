defmodule DiscussionWeb.HelloController do
  use DiscussionWeb, :controller

  def index(conn, _params) do
    # render(conn, :index)
    # redirect(conn, to: ~p"/testing/redirect")
    # redirect(conn, external: "https://elixir-lang.org/")

    # different syntax
    conn
    |> put_flash(:info, "You are being redirected!")
    |> redirect(to: ~p"/testing/redirect")

    # for error flash, instead of :info, put :error
  end

  def show(conn, %{"messenger" => messenger} = _params) do
    # IO.inspect(params)
    #  Parameters: %{"messenger" => "mica"}
    # render(conn, :show, messenger: messenger)

    # different syntax
    conn
    # |> Plug.Conn.assign(:messenger, messenger) no need to write like this because if you check discussion_web.ex you see import Plug.Conn inside controller; so you can just call assign
    |> assign(:messenger, messenger)
    |> render(:show)
  end

  def redirect_test(conn, _params) do
    render(conn, :index)
  end
end
