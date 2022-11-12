defmodule Pay.Domain.Entities.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Ecto.Changeset
  alias Pay.Domain.Entities.Account

  @require_params [:name, :age, :email, :password, :nickname]

  @primary_key{:id, :binary_id, autogenerate: true}

  schema "users" do
    field :name, :string
    field :age, :integer
    field :email, :string
    field :password, :string, virtual: true #only exists in schema
    field :password_hash, :string
    field :nickname, :string
    has_one :account, Account #Ecto never load a schema without ask

    timestamps()
  end

  def changeset(params) do
    %__MODULE__{} #empty struct changeset
    |> cast(params, @require_params)
    |> validate_required(@require_params)
    |> validate_length(:password, min: 6)
    |> validate_number(:age, greater_than_or_equal_to: 18)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
    |> unique_constraint(:nickname)
    |> put_password_hash()
  end

  # Changeset read the struct and his fields, valid? is one of the fields
  defp put_password_hash(%Changeset{valid?: true, changes: %{password: password}} = changeset) do
    # change receives a schema and change a value password as configured in param
    # the return from Bcrypt.add_hash is a mapper with password_hash, that's why this change in schema
    change(changeset, Bcrypt.add_hash(password))
  end

  defp put_password_hash(changeset), do: changeset
end
