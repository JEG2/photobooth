defmodule PhotoboothWeb.HomeController do
  use PhotoboothWeb, :controller

  def index(conn, _params) do
    Picam.set_img_effect(:none)
    Picam.set_size(640, 0)
    Picam.set_rotation(270)

    render(conn, "index.html")
  end
end
