defmodule MyApp.TodoListFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `MyApp.TodoList` context.
  """

  @doc """
  Generate a item.
  """
  def item_fixture(attrs \\ %{}) do
    {:ok, item} =
      attrs
      |> Enum.into(%{
        complete: true,
        title: "some title"
      })
      |> MyApp.TodoList.create_item()

    item
  end
end
