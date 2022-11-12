defmodule Pay.Domain.UseCases.CreateUserWithAccount do
  alias Module.Types.Of
  alias Pay.Repo
  alias Pay.Domain.Entities.{User, Account}
  alias Ecto.Multi

  def call(params) do
    Multi.new()
    |> Multi.insert(:create_user, User.changeset(params))
    # Multi.run always receives the name of the first function
    # Always needs anonymous function as second parameter and this function receives
    # Repo as first and secont a struct with the same name odmf first function
    |> Multi.run(:create_account, fn repo, %{create_user: user} -> insert_account(repo, user) end)
    |> Multi.run(:preload_data, fn repo, %{create_user: user} -> preload_data(repo, user) end)
    |> run_transaction()
  end

  defp insert_account(repo, user) do
    user.id
    |> account_changeset()
    |> repo.insert()
  end

  defp preload_data(repo, user) do
    {:ok, repo.preload(user, :account)}
  end

  defp account_changeset(user_id) do
    params = %{user_id: user_id, balance: "0.00"}

    Account.changeset(params)
  end

  defp run_transaction(multi) do
    case Repo.transaction(multi) do
      {:error, _operation, reason, _changes} -> {:error, reason} # This is the same as return
      # %{} this is a map
      {:ok, %{preload_data: user}} -> {:ok, user}
    end
  end
end
