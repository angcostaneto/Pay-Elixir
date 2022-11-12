defmodule PayWeb.AccountDepositView do
  alias Pay.Domain.Entities.Account

  def render("update.json", %{
    account: %Account{
      id: account_id,
      balance: balance
    }
  }) do
    %{
      message: "Balance changed succesfully",
      account: %{
        id: account_id,
        balance: balance
      }
    }
  end
end
