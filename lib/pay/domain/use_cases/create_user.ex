defmodule Pay.Domain.UseCases.CreateUser do
  alias Pay.Repo
  alias Pay.Domain.Entities.User

  def call(params) do
    params
    |> User.changeset()
    |> Repo.insert()
  end
end
