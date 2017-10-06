defmodule PhotoboothWeb.PageController do
  use PhotoboothWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
