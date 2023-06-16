defmodule CollegeTrackerWeb.ActivityLive.Index do
  use CollegeTrackerWeb, :live_view

  alias CollegeTracker.ExtracurricularActivities
  alias CollegeTracker.ExtracurricularActivities.Activity

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :activities, ExtracurricularActivities.list_activities())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Activity")
    |> assign(:activity, ExtracurricularActivities.get_activity!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Activity")
    |> assign(:activity, %Activity{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Activities")
    |> assign(:activity, nil)
  end

  @impl true
  def handle_info({CollegeTrackerWeb.ActivityLive.FormComponent, {:saved, activity}}, socket) do
    {:noreply, stream_insert(socket, :activities, activity)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    activity = ExtracurricularActivities.get_activity!(id)
    {:ok, _} = ExtracurricularActivities.delete_activity(activity)

    {:noreply, stream_delete(socket, :activities, activity)}
  end
end
