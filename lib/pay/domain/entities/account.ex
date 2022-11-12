defmodule Pay.Domain.Entities.Account do
  use Ecto.Schema
  import Ecto.Changeset
  alias Ecto.Changeset
  alias Ecto.Entities.User

  @require_params [:balance, :user_id]

  @primary_key{:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "accounts" do
    field :balance, :decimal
    belongs_to :user, User

    timestamps()
  end

  # Are two ways to work changeset, changeset of creation, that %__MODULE__{} is started
  # And changeset of update, where changeset start with a struct already fullfield and update only field when are changeds
  # \\ means default param, like numer_1 = 0
  def changeset(struct \\ %__MODULE__{}, params) do
    struct #empty struct changeset
    |> cast(params, @require_params)
    |> validate_required(@require_params)
    |> check_constraint(:balance, name: :balance_must_be_positive_or_zero)
  end
end
