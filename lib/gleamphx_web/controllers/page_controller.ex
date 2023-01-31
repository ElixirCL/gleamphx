defmodule GleamphxWeb.PageController do
  use GleamphxWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
