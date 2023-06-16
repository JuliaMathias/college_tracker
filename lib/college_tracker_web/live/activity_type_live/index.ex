defmodule CollegeTrackerWeb.ActivityTypeLive.Index do
  use CollegeTrackerWeb, :live_view

  alias CollegeTracker.ExtracurricularActivities
  alias CollegeTracker.ExtracurricularActivities.ActivityType

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :activity_types, ExtracurricularActivities.list_activity_types())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Activity type")
    |> assign(:activity_type, ExtracurricularActivities.get_activity_type!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Activity type")
    |> assign(:activity_type, %ActivityType{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Activity types")
    |> assign(:activity_type, nil)
  end

  @impl true
  def handle_info(
        {CollegeTrackerWeb.ActivityTypeLive.FormComponent, {:saved, activity_type}},
        socket
      ) do
    {:noreply, stream_insert(socket, :activity_types, activity_type)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    activity_type = ExtracurricularActivities.get_activity_type!(id)
    {:ok, _} = ExtracurricularActivities.delete_activity_type(activity_type)

    {:noreply, stream_delete(socket, :activity_types, activity_type)}
  end
end
