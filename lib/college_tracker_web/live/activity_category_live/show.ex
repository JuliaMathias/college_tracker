defmodule CollegeTrackerWeb.ActivityCategoryLive.Show do
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
     |> assign(:activity_category, ExtracurricularActivities.get_activity_category!(id))}
  end

  defp page_title(:show), do: "Show Activity category"
  defp page_title(:edit), do: "Edit Activity category"
end
