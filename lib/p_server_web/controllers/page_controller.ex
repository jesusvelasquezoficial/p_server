defmodule PServerWeb.PageController do
  use PServerWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
