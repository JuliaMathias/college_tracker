defmodule CollegeTrackerWeb.ActivityTypeLive.FormComponent do
  use CollegeTrackerWeb, :live_component

  alias CollegeTracker.ExtracurricularActivities
  alias CollegeTracker.Repo

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage activity_type records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="activity_type-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:total_limit]} type="number" label="Total limit" />
        <.input field={@form[:individual_limit]} type="number" label="Individual limit" />
        <.input field={@form[:remaining_limit]} type="number" label="Remaining limit" />
        <.input
          field={@form[:status]}
          type="select"
          label="Status"
          prompt="Choose a value"
          options={Ecto.Enum.values(CollegeTracker.ExtracurricularActivities.ActivityType, :status)}
        />
        <.input
          field={@form[:activity_category_id]}
          type="select"
          label="Activity Category"
          prompt="Choose a category"
          options={@category_options}
        />

        <:actions>
          <.button phx-disable-with="Saving...">Save Activity type</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{activity_type: activity_type} = assigns, socket) do
    changeset = ExtracurricularActivities.change_activity_type(activity_type)

    categories = Repo.all(ExtracurricularActivities.ActivityCategory)
    category_options = for category <- categories, do: {category.name, category.id}

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)
     |> assign(:category_options, category_options)}
  end

  @impl true
  def handle_event("validate", %{"activity_type" => activity_type_params}, socket) do
    changeset =
      socket.assigns.activity_type
      |> ExtracurricularActivities.change_activity_type(activity_type_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"activity_type" => activity_type_params}, socket) do
    save_activity_type(socket, socket.assigns.action, activity_type_params)
  end

  defp save_activity_type(socket, :edit, activity_type_params) do
    case ExtracurricularActivities.update_activity_type(
           socket.assigns.activity_type,
           activity_type_params
         ) do
      {:ok, activity_type} ->
        notify_parent({:saved, activity_type})

        {:noreply,
         socket
         |> put_flash(:info, "Activity type updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_activity_type(socket, :new, activity_type_params) do
    case ExtracurricularActivities.create_activity_type(activity_type_params) do
      {:ok, activity_type} ->
        notify_parent({:saved, activity_type})

        {:noreply,
         socket
         |> put_flash(:info, "Activity type created successfully")
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
