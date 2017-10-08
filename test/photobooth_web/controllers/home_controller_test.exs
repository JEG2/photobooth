defmodule PhotoboothWeb.HomeControllerTest do
  use PhotoboothWeb.ConnCase

  alias Photobooth.NotUsed

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:home) do
    {:ok, home} = NotUsed.create_home(@create_attrs)
    home
  end

  describe "index" do
    test "lists all homes", %{conn: conn} do
      conn = get conn, home_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Homes"
    end
  end

  describe "new home" do
    test "renders form", %{conn: conn} do
      conn = get conn, home_path(conn, :new)
      assert html_response(conn, 200) =~ "New Home"
    end
  end

  describe "create home" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, home_path(conn, :create), home: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == home_path(conn, :show, id)

      conn = get conn, home_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Home"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, home_path(conn, :create), home: @invalid_attrs
      assert html_response(conn, 200) =~ "New Home"
    end
  end

  describe "edit home" do
    setup [:create_home]

    test "renders form for editing chosen home", %{conn: conn, home: home} do
      conn = get conn, home_path(conn, :edit, home)
      assert html_response(conn, 200) =~ "Edit Home"
    end
  end

  describe "update home" do
    setup [:create_home]

    test "redirects when data is valid", %{conn: conn, home: home} do
      conn = put conn, home_path(conn, :update, home), home: @update_attrs
      assert redirected_to(conn) == home_path(conn, :show, home)

      conn = get conn, home_path(conn, :show, home)
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, home: home} do
      conn = put conn, home_path(conn, :update, home), home: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Home"
    end
  end

  describe "delete home" do
    setup [:create_home]

    test "deletes chosen home", %{conn: conn, home: home} do
      conn = delete conn, home_path(conn, :delete, home)
      assert redirected_to(conn) == home_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, home_path(conn, :show, home)
      end
    end
  end

  defp create_home(_) do
    home = fixture(:home)
    {:ok, home: home}
  end
end
