defmodule Pay do
  @moduledoc """
  Pay keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  # This creates a facade for insert create user
  alias Pay.Domain.UseCases.{CreateUser, CreateUserWithAccount, AccountDeposit, AccountWithdraw}
  defdelegate create_user(params), to: CreateUser, as: :call
  defdelegate create_user_with_account(params), to: CreateUserWithAccount, as: :call
  defdelegate deposit(params), to: AccountDeposit, as: :call
  defdelegate withdraw(params), to: AccountWithdraw, as: :call
end
