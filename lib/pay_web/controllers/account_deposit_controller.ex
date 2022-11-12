defmodule PayWeb.AccountDepositController do
  alias Pay.Domain.Entities.Account
  use PayWeb, :controller

  action_fallback PayWeb.FallbackController

  def execute(conn, params) do
    with {:ok, %Account{} = account} <- Pay.deposit(params) do
      conn
    |> put_status(:ok)
    |> render("update.json", account: account)
    end
  end

end
