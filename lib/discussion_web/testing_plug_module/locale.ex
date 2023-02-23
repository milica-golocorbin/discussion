defmodule DiscussionWeb.TestingPlugModule.Locale do
  import Plug.Conn

  @locales ["en", "es"]

  def init(default), do: default

  def call(%Plug.Conn{params: %{"locale" => loc}} = conn, _default) when loc in @locales do
    assign(conn, :locale, loc)
  end

  def call(conn, default) do
    assign(conn, :locale, default)
  end
end

# The assign/3 is a part of the Plug.Conn module and it's how we store values in the conn data structure.
