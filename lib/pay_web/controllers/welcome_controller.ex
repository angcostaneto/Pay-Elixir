defmodule PayWeb.WelcomeController do
  use PayWeb, :controller

  def index(conn, _params) do
    text(conn, "Welcome Pay api")
  end
end
