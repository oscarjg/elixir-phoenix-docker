defmodule ComitiumLiveEventsWeb.LiveEventChannelTest do
  use ComitiumLiveEventsWeb.ChannelCase, async: true

  setup do
    {:ok, _, socket} =
      socket(ComitiumLiveEventsWeb.UserSocket, "user_id", %{app_key: "foo-key", user_id: 1, application_id: 1})
      |> subscribe_and_join(ComitiumLiveEventsWeb.LiveEventChannel, "live_event:lobby", %{app_key: "foo-key"})

    {:ok, socket: socket}
  end

  describe "push messages" do
    test "push create event should be broadcast onCreate event", %{socket: socket} do
      live_data = %{"id" => 1, "title" => "Foo bar title"}
      push socket, "create", live_data
      assert_broadcast "create", live_data
    end

    test "push update event should be broadcast onCreate event", %{socket: socket} do
      live_data = %{"id" => 1, "title" => "Foo bar title"}
      push socket, "update", live_data
      assert_broadcast "update", live_data
    end

    test "push delete event should be broadcast onCreate event", %{socket: socket} do
      live_data = %{"id" => 1, "title" => "Foo bar title"}
      push socket, "delete", live_data
      assert_broadcast "delete", live_data
    end
  end

  describe "error cases" do
    test "unauthorized response should be on connect with another app key" do
      assert {:error, %{reason: "unauthorized"}} =
               socket(ComitiumLiveEventsWeb.UserSocket, "user_id", %{app_key: "foo-key", user_id: 1, application_id: 1})
               |> subscribe_and_join(ComitiumLiveEventsWeb.LiveEventChannel, "live_event:lobby", %{"app_key" => "bar-key"})
    end

    test "unauthorized response should be on connect without app key" do
      assert {:error, %{reason: "unauthorized"}} =
               socket(ComitiumLiveEventsWeb.UserSocket, "user_id", %{app_key: "foo-key", user_id: 1, application_id: 1})
               |> subscribe_and_join(ComitiumLiveEventsWeb.LiveEventChannel, "live_event:lobby")
    end
  end
end
