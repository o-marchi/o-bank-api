defmodule ObankWeb.Plugs.AddAuthorizationHeader do
	import Plug.Conn

	alias Obank.Guardian


	def init(_params), do: _params

	def call(conn, _params) do

	    case conn.assigns[:user] |> Guardian.encode_and_sign do
	    	{:ok, token, _claims} -> 
					put_resp_header(conn, "Authorization", "Bearer #{token}")
				true ->
					conn
	    end
	end
end