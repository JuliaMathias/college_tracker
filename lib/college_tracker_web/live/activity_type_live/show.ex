defmodule CollegeTrackerWeb.ActivityTypeLive.Show do
  use CollegeTrackerWeb, :live_view

  alias CollegeTracker.ExtracurricularActivities

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:activity_type, ExtracurricularActivities.get_activity_type!(id))}
  end

  defp page_title(:show), do: "Show Activity type"
  defp page_title(:edit), do: "Edit Activity type"
end
