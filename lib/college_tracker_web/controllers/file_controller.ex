defmodule CollegeTrackerWeb.FileController do
  use CollegeTrackerWeb, :controller

  def download(conn, %{"file" => file}) do
    path = Path.join("priv/static/uploads", file)

    send_download(conn, {:file, path})
  end
end
