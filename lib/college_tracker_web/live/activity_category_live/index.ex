defmodule CollegeTrackerWeb.ActivityCategoryLive.Index do
  use CollegeTrackerWeb, :live_view

  alias CollegeTracker.ExtracurricularActivities
  alias CollegeTracker.ExtracurricularActivities.ActivityCategory

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     stream(socket, :activity_categories, ExtracurricularActivities.list_activity_categories())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Activity category")
    |> assign(:activity_category, ExtracurricularActivities.get_activity_category!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Activity category")
    |> assign(:activity_category, %ActivityCategory{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Activity categories")
    |> assign(:activity_category, nil)
  end

  @impl true
  def handle_info(
        {CollegeTrackerWeb.ActivityCategoryLive.FormComponent, {:saved, activity_category}},
        socket
      ) do
    {:noreply, stream_insert(socket, :activity_categories, activity_category)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    activity_category = ExtracurricularActivities.get_activity_category!(id)
    {:ok, _} = ExtracurricularActivities.delete_activity_category(activity_category)

    {:noreply, stream_delete(socket, :activity_categories, activity_category)}
  end
end
