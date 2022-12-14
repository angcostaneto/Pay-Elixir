defmodule PayWeb.CreateUserView do
  alias Pay.Domain.Entities.{User, Account}

  def render("create_user.json", %{
    user: %User{account: %Account{id: account_id, balance: balance}, id: id, name: name, nickname: nickname}
  }) do
    %{
      message: "User created",
      user: %{
        id: id,
        name: name,
        nickname: nickname,
        account: %{
          id: account_id,
          balance: balance
        }
      }
    }
  end
end
