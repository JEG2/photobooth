defmodule PhotoboothWeb.HomeView do
  use PhotoboothWeb, :view

  def render("snap.json", %{result: "ok"}), do: %{"result" => "ok"}
end
