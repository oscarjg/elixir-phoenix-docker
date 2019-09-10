defmodule ComitiumLiveEventsWeb.LiveEventChannel do
  use ComitiumLiveEventsWeb, :channel

  def join("live_event:lobby", payload, socket) do
    if authorized?(payload, socket) do
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  def handle_in("create", payload, socket) do
    broadcast socket, "create", payload
    {:noreply, socket}
  end

  def handle_in("update", payload, socket) do
    broadcast socket, "update", payload
    {:noreply, socket}
  end

  def handle_in("delete", payload, socket) do
    broadcast socket, "delete", payload
    {:noreply, socket}
  end

  defp authorized?(payload, socket) do
    IO.inspect(Map.has_key?(payload, "app_key"))
    IO.inspect(payload["app_key"])
    IO.inspect(socket.assigns)
    cond do
      Map.has_key?(payload, "app_key") == false
        -> false
      payload["app_key"] != socket.assigns.app_key
        -> false
      true
        ->
          true
    end
  end
end
