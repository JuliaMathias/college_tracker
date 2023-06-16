defmodule CollegeTrackerWeb.ActivityCategoryLive.FormComponent do
  use CollegeTrackerWeb, :live_component

  alias CollegeTracker.ExtracurricularActivities

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage activity_category records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="activity_category-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:limit]} type="number" label="Limit" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Activity category</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{activity_category: activity_category} = assigns, socket) do
    changeset = ExtracurricularActivities.change_activity_category(activity_category)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"activity_category" => activity_category_params}, socket) do
    changeset =
      socket.assigns.activity_category
      |> ExtracurricularActivities.change_activity_category(activity_category_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"activity_category" => activity_category_params}, socket) do
    save_activity_category(socket, socket.assigns.action, activity_category_params)
  end

  defp save_activity_category(socket, :edit, activity_category_params) do
    case ExtracurricularActivities.update_activity_category(
           socket.assigns.activity_category,
           activity_category_params
         ) do
      {:ok, activity_category} ->
        notify_parent({:saved, activity_category})

        {:noreply,
         socket
         |> put_flash(:info, "Activity category updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_activity_category(socket, :new, activity_category_params) do
    case ExtracurricularActivities.create_activity_category(activity_category_params) do
      {:ok, activity_category} ->
        notify_parent({:saved, activity_category})

        {:noreply,
         socket
         |> put_flash(:info, "Activity category created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
