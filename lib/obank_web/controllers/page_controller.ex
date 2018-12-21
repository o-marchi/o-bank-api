defmodule ObankWeb.PageController do
  use ObankWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
