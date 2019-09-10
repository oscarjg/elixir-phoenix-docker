defmodule ApplicationAuth.Accounts.UserTest do
  use ApplicationAuth.Support.DataBaseCase

  alias ApplicationAuth.Accounts.User

  test "valid changeset" do
    assert {:ok, %User{}} = user_fixture(%{name: "foo name"})
  end

  test "required changeset fields should return an expected error" do
    assert {:error, %Ecto.Changeset{valid?: false}} = user_fixture(%{name: ""})
  end

  test "validate client credentials" do
    assert {:ok, %User{}} =
             user_fixture(%{
               name: "foo name",
               credential: %{email: "foo@bar.com", password: "123456"}
             })

    assert {:error, %Ecto.Changeset{}} =
             user_fixture(%{name: "foo name", credential: %{email: "foo@bar.com", password: ""}})

    assert {:error, %Ecto.Changeset{}} =
             user_fixture(%{
               name: "foo name",
               credential: %{email: "foo@bar.com", password: "12345"}
             })

    assert {:error, %Ecto.Changeset{}} =
             user_fixture(%{name: "foo name", credential: %{email: "", password: ""}})

    assert {:error, %Ecto.Changeset{}} =
             user_fixture(%{
               name: "foo name",
               credential: %{email: "foo%bar.com", password: "123456"}
             })
  end
end
