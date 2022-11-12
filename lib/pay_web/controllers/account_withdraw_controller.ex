defmodule PayWeb.AccountWithdrawController do
  alias Pay.Domain.Entities.Account
  use PayWeb, :controller

  action_fallback PayWeb.FallbackController

  def execute(conn, params) do
    with {:ok, %Account{} = account} <- Pay.withdraw(params) do
      conn
    |> put_status(:ok)
    |> IO.inspect()
    |> render("update.json", account: account)
    end
  end
end
