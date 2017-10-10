defmodule PhotoboothWeb.HomeController do
  use PhotoboothWeb, :controller
  alias Photobooth.Camera

  def index(conn, _params) do
    render conn, "index.html"
  end

  def snap(conn, _params) do
    Camera.snap
    render conn, "snap.json", %{result: "ok"}
  end
end
