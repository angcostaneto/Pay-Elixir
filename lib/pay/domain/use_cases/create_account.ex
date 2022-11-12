defmodule Pay.Domain.UseCases.CreateAccount do
  alias Pay.Repo
  alias Pay.Domain.Entities.Account

  def call(params) do
    params
    |> Account.changeset()
    |> Repo.insert()
  end
end
