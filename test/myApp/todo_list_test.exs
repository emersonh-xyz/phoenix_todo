defmodule MyApp.TodoListTest do
  use MyApp.DataCase

  alias MyApp.TodoList

  describe "items" do
    alias MyApp.TodoList.Item

    import MyApp.TodoListFixtures

    @invalid_attrs %{complete: nil, title: nil}

    test "list_items/0 returns all items" do
      item = item_fixture()
      assert TodoList.list_items() == [item]
    end

    test "get_item!/1 returns the item with given id" do
      item = item_fixture()
      assert TodoList.get_item!(item.id) == item
    end

    test "create_item/1 with valid data creates a item" do
      valid_attrs = %{complete: true, title: "some title"}

      assert {:ok, %Item{} = item} = TodoList.create_item(valid_attrs)
      assert item.complete == true
      assert item.title == "some title"
    end

    test "create_item/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = TodoList.create_item(@invalid_attrs)
    end

    test "update_item/2 with valid data updates the item" do
      item = item_fixture()
      update_attrs = %{complete: false, title: "some updated title"}

      assert {:ok, %Item{} = item} = TodoList.update_item(item, update_attrs)
      assert item.complete == false
      assert item.title == "some updated title"
    end

    test "update_item/2 with invalid data returns error changeset" do
      item = item_fixture()
      assert {:error, %Ecto.Changeset{}} = TodoList.update_item(item, @invalid_attrs)
      assert item == TodoList.get_item!(item.id)
    end

    test "delete_item/1 deletes the item" do
      item = item_fixture()
      assert {:ok, %Item{}} = TodoList.delete_item(item)
      assert_raise Ecto.NoResultsError, fn -> TodoList.get_item!(item.id) end
    end

    test "change_item/1 returns a item changeset" do
      item = item_fixture()
      assert %Ecto.Changeset{} = TodoList.change_item(item)
    end
  end
end
