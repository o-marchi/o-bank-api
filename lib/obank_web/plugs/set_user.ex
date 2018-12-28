defmodule ObankWeb.Plugs.SetUser do
	import Plug.Conn

	alias Obank.Guardian


	def init(_params), do: _params

	def call(conn, _params) do
		user = Guardian.Plug.current_resource(conn)
		assign(conn, :user, user)
	end
end