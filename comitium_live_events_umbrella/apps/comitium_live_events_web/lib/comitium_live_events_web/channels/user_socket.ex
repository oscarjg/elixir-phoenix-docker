defmodule ComitiumLiveEventsWeb.UserSocket do
  use Phoenix.Socket

  ## Channels
  # channel "room:*", ComitiumLiveEventsWeb.RoomChannel
  channel "live_event:lobby", ComitiumLiveEventsWeb.LiveEventChannel

  # Socket params are passed from the client and can
  # be used to verify and authenticate a user. After
  # verification, you can put default assigns into
  # the socket that will be set for all channels, ie
  #
  #     {:ok, assign(socket, :user_id, verified_user_id)}
  #
  # To deny connection, return `:error`.
  #
  # See `Phoenix.Token` documentation for examples in
  # performing token verification on connect.
  def connect(%{"app_key" => app_key}, socket, %{:uri => %URI{host: host}}) do
    case ApplicationAuth.Accounts.authenticate_application(app_key, host) do
      {:ok, application} ->
        socket = socket
          |> assign(:user_id, application.user.id)
          |> assign(:application_id, application.id)
          |> assign(:app_key, app_key)

        {:ok, socket}
      {:error, _} ->
        :error
    end
  end

  def connect(_params, _socket, _connect_info), do: :error

  # Socket id's are topics that allow you to identify all sockets for a given user:
  #
  #     def id(socket), do: "user_socket:#{socket.assigns.user_id}"
  #
  # Would allow you to broadcast a "disconnect" event and terminate
  # all active sockets and channels for a given user:
  #
  #     ComitiumLiveEventsWeb.Endpoint.broadcast("user_socket:#{user.id}", "disconnect", %{})
  #
  # Returning `nil` makes this socket anonymous.
  def id(_socket), do: nil
end
