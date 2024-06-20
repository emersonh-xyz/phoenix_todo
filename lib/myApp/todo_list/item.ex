defmodule MyApp.TodoList.Item do
  use Ecto.Schema
  import Ecto.Changeset

  schema "items" do
    field :complete, :boolean, default: false
    field :title, :string

    belongs_to :user, MyApp.Accounts.User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(item, attrs) do
    item
    |> cast(attrs, [:title, :complete, :user_id])
    |> validate_required([:title, :complete, :user_id])
  end
end
