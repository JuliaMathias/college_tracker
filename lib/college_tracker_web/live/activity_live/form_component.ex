defmodule CollegeTrackerWeb.ActivityLive.FormComponent do
  use CollegeTrackerWeb, :live_component

  alias CollegeTracker.ExtracurricularActivities
  alias CollegeTracker.Repo

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage activity records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="activity-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input
          field={@form[:activity_type_id]}
          type="select"
          label="Activity Type"
          prompt="Choose a type"
          options={@type_options}
        />
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:description]} type="text" label="Description" />
        <.input
          field={@form[:status]}
          type="select"
          label="Status"
          prompt="Choose a value"
          options={Ecto.Enum.values(CollegeTracker.ExtracurricularActivities.Activity, :status)}
        />
        <.input field={@form[:hours]} type="number" label="Hours" />
        <.input field={@form[:start_date]} type="date" label="Start date" />
        <.input field={@form[:end_date]} type="date" label="End date" />
        <.input field={@form[:submission_date]} type="date" label="Submission date" />
        <.input field={@form[:certificate]} type="text" label="Certificate" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Activity</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{activity: activity} = assigns, socket) do
    changeset = ExtracurricularActivities.change_activity(activity)

    types = Repo.all(ExtracurricularActivities.ActivityType)
    type_options = for type <- types, do: {type.name, type.id}

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)
     |> assign(type_options: type_options)}
  end

  @impl true
  def handle_event("validate", %{"activity" => activity_params}, socket) do
    changeset =
      socket.assigns.activity
      |> ExtracurricularActivities.change_activity(activity_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"activity" => activity_params}, socket) do
    save_activity(socket, socket.assigns.action, activity_params)
  end

  defp save_activity(socket, :edit, activity_params) do
    case ExtracurricularActivities.update_activity(socket.assigns.activity, activity_params) do
      {:ok, activity} ->
        notify_parent({:saved, activity})

        {:noreply,
         socket
         |> put_flash(:info, "Activity updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_activity(socket, :new, activity_params) do
    case ExtracurricularActivities.create_activity(activity_params) do
      {:ok, activity} ->
        notify_parent({:saved, activity})

        {:noreply,
         socket
         |> put_flash(:info, "Activity created successfully")
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
