defmodule UserSocketTest do
  use ComitiumLiveEventsWeb.ChannelCase, async: true

  alias ComitiumLiveEventsWeb.UserSocket

  test "socket authentication with valid credentials" do
    {:ok, user} = user_fixture()
    {:ok, app}  = application_fixture(user, allowed_hosts: "127.0.0.1")

    app_key = app.credential.app_key
    assert {:ok, socket} = connect(UserSocket, %{"app_key" => app_key}, %{:uri => %URI{host: "127.0.0.1"}})
    assert socket.assigns.user_id == user.id
    assert socket.assigns.application_id == app.id
    assert socket.assigns.app_key == app_key
  end

  test "socket authentication with invalid credentials should return an error" do
    {:ok, user} = user_fixture()
    {:ok, app}  = application_fixture(user, allowed_hosts: "127.0.0.1")

    app_key = app.credential.app_key

    assert :error = connect(UserSocket, %{"app_key" => app_key}, %{:uri => %URI{host: "192.168.1.1"}})
    assert :error = connect(UserSocket, %{"app_key" => app_key}, %{})
    assert :error = connect(UserSocket, %{"app_key" => "foo-bar"}, %{:uri => %URI{host: "127.0.0.1"}})
  end
end
