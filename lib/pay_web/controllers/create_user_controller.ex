defmodule PayWeb.CreateUserController do
  alias Pay.Domain.Entities.User
  use PayWeb, :controller

  action_fallback PayWeb.FallbackController

  def execute(conn, params) do
    # With verify case if this case work, he execute function body
    # If this case fail he returns to fallback controller
    # With is a pattern match
    with {:ok,  %User{} = user} <- Pay.create_user_with_account(params) do
      conn
    |> put_status(:created)
    |> render("create_user.json", user: user)
    end
  end

end
