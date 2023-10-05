defmodule ChampionsWeb.UserLive.Show do
  use ChampionsWeb, :live_view

  alias Champions.Accounts

  @impl true
  def handle_params(%{"id" => id}, _session, socket) do
    try do
      user = Accounts.get_user!(id)

      {:noreply,
       socket
       |> assign(:page_title, "Showing user #{user.email}")
       |> assign(:user, user)}
    rescue
      _ ->
        {:noreply,
         socket
         |> put_flash(:error, "There is no user with ID #{id}")
         |> redirect(to: ~p"/users")}
    end
  end

  @impl true
  def render(assigns) do
    ~H"""
    <.header>
      User <%= @user.id %>
      <:subtitle>This is a player on this app.</:subtitle>
    </.header>

    <.list>
      <:item title="Email"><%= @user.email %></:item>
      <:item title="Points"><%= @user.points %></:item>
    </.list>

    <.back navigate={~p"/users"}>Back to users</.back>
    """
  end
end
