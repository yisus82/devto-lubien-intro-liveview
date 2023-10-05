defmodule ChampionsWeb.UserLiveTest do
  use ChampionsWeb.ConnCase

  import Phoenix.LiveViewTest
  import Champions.AccountsFixtures

  defp create_user(_) do
    user = user_fixture()
    %{user: user}
  end

  describe "Index" do
    setup [:create_user]

    test "lists all users", %{conn: conn, user: user} do
      {:ok, _index_live, html} = live(conn, ~p"/users")

      assert html =~ "Listing Users"
      assert html =~ user.email
    end
  end

  describe "Show" do
    setup [:create_user]

    test "displays user", %{conn: conn, user: user} do
      {:ok, _show_live, html} = live(conn, ~p"/users/#{user}")

      assert html =~ "This is a player on this app"
      assert html =~ user.email
    end

    test "redirects to users index with flash message when user does not exist", %{
      conn: conn,
      user: _user
    } do
      {:error, show_live} = live(conn, ~p"/users/invalid-id")

      assert show_live ==
               {:redirect,
                %{to: "/users", flash: %{"error" => "There is no user with ID invalid-id"}}}
    end
  end
end
